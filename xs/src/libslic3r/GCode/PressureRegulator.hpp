#ifndef slic3r_PressureRegulator_hpp_
#define slic3r_PressureRegulator_hpp_

#include "libslic3r.h"
#include "GCodeReader.hpp"

namespace Slic3r {

/// Slicer-side pressure advance: pushes extra filament when the flow rate rises
/// and takes it back before retractions (K = pressure_advance). Needs no firmware
/// support. Port of lib/Slic3r/GCode/PressureRegulator.pm. The algorithm was
/// proposed by Matthew Roberts; the first Slic3r version was by Luís Andrade.
class PressureRegulator {
    public:
    PressureRegulator(const PrintConfig &config)
        : _config(&config), _extrusion_axis(config.get_extrusion_axis())
    {
        this->_reader.apply_config(config);
    };
    std::string process(const std::string &gcode, bool flush);

    private:
    const PrintConfig* _config;
    GCodeReader _reader;
    std::string _extrusion_axis;
    unsigned int _tool {0};
    double _last_print_F {0};
    double _advance {0};  // extra E injected

    /// F = 0 means "not given": the unretract speed is used, and
    /// restore_F = 0 writes no F restore line.
    std::string _discharge(double F = 0, double restore_F = 0);
    double _unretract_speed() const { return this->_config->retract_speed.get_at(this->_tool) * 60; };
};

}

#endif
