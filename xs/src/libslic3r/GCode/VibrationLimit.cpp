#include "VibrationLimit.hpp"
#include <algorithm>
#include <cstdio>

namespace Slic3r {

std::string
VibrationLimit::process(const std::string &gcode)
{
    std::string out;
    this->_reader.parse(gcode, [this, &out](GCodeReader &reader, const GCodeReader::GCodeLine &line) {
        const double dist_XY = line.dist_XY();
        // the Perl reader has no XY distance for anything but G0/G1
        if (line.cmd == "G1" && dist_XY > 0 && line.new_F() > 0) {
            const double new_pos[2] { line.new_X(), line.new_Y() };
            const double old_pos[2] { reader.X, reader.Y };
            const double time = dist_XY / line.new_F();  // minutes
            double pause = 0;
            bool need_pause = false;
            for (int axis = 0; axis < 2; ++axis) {
                const int dir = (new_pos[axis] > old_pos[axis]) - (new_pos[axis] < old_pos[axis]);
                if (dir != 0 && this->_last_dir[axis] != dir) {
                    // this axis is changing direction: check whether we need to pause
                    if (this->_last_dir[axis] != 0 && this->_dir_time[axis] < this->_min_time) {
                        pause = std::max(pause, this->_min_time - this->_dir_time[axis]);
                        need_pause = true;
                    }
                    this->_last_dir[axis] = dir;
                    this->_dir_time[axis] = 0;
                }
                this->_dir_time[axis] += time;
            }
            if (need_pause) {
                char buf[64];
                snprintf(buf, sizeof(buf), "G4 P%d\n", int(pause * 60 * 1000));  // %d truncates, as in Perl
                out += buf;
            }
        }
        out += line.raw + "\n";
    });
    return out;
}

}
