#include "PressureRegulator.hpp"
#include <cctype>
#include <cmath>
#include <cstdarg>
#include <cstdio>
#include <cstdlib>

namespace Slic3r {

static std::string
format(const char* fmt, ...)
{
    char buf[128];
    va_list args;
    va_start(args, fmt);
    vsnprintf(buf, sizeof(buf), fmt, args);
    va_end(args);
    return buf;
}

std::string
PressureRegulator::process(const std::string &gcode, bool flush)
{
    const bool relative_e = this->_config->use_relative_e_distances.value;
    std::string out;
    this->_reader.parse(gcode, [this, &out, relative_e](GCodeReader &reader, const GCodeReader::GCodeLine &line) {
        if (line.cmd.size() > 1 && line.cmd[0] == 'T' && isdigit(line.cmd[1])) {
            this->_tool = atoi(line.cmd.c_str() + 1);
        } else if (line.extruding() && line.dist_XY() > 0) {
            // This is a print move.
            const double F = line.new_F();
            if (F != this->_last_print_F || this->_advance == 0) {
                // A (potentially) new speed, or a discharge happened since the last
                // speed change: calculate the new advance amount.
                const double rel_flow_rate = line.dist_E() / line.dist_XY();  // mm filament per mm travel
                const double flow_rate = rel_flow_rate * F / 60;                // mm/s of feedstock
                const double new_advance = this->_config->pressure_advance.value * flow_rate * flow_rate;
                if (std::abs(new_advance - this->_advance) > 1E-5) {
                    const double new_E = (relative_e ? 0 : reader.E) + (new_advance - this->_advance);
                    out += format("G1 %s%.5f F%.3f ; pressure advance\n", this->_extrusion_axis.c_str(), new_E, this->_unretract_speed());
                    if (!relative_e)
                        out += format("G92 %s%.5f ; restore E\n", this->_extrusion_axis.c_str(), reader.E);
                    out += format("G1 F%.3f ; restore F\n", F);
                    this->_advance = new_advance;
                }
                this->_last_print_F = F;
            }
        } else if ((line.retracting() || line.cmd == "G10") && this->_advance != 0) {
            // We need to bring pressure to zero when retracting.
            const double F = line.has('F') ? line.get_float('F') : 0;
            out += this->_discharge(F, line.new_F());
        }
        out += line.raw + "\n";
    });
    if (flush) out += this->_discharge();  // unconditional, as in Perl
    return out;
}

std::string
PressureRegulator::_discharge(double F, double restore_F)
{
    const bool relative_e = this->_config->use_relative_e_distances.value;
    const double new_E = (relative_e ? 0 : this->_reader.E) - this->_advance;
    std::string gcode = format("G1 %s%.5f F%.3f ; pressure discharge\n", this->_extrusion_axis.c_str(),
        new_E, F != 0 ? F : this->_unretract_speed());
    if (!relative_e)
        gcode += format("G92 %s%.5f ; restore E\n", this->_extrusion_axis.c_str(), this->_reader.E);
    if (restore_F != 0)
        gcode += format("G1 F%.3f ; restore F\n", restore_F);
    this->_advance = 0;
    return gcode;
}

}
