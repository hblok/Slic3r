#ifndef slic3r_VibrationLimit_hpp_
#define slic3r_VibrationLimit_hpp_

#include "libslic3r.h"
#include "GCodeReader.hpp"

namespace Slic3r {

/// Inserts pauses (G4) so that no axis changes direction more often than
/// vibration_limit times per second. Port of lib/Slic3r/GCode/VibrationLimit.pm,
/// inspired by http://hydraraptor.blogspot.it/2010/12/frequency-limit.html
class VibrationLimit {
    public:
    VibrationLimit(const PrintConfig &config)
        : _min_time(config.vibration_limit.value > 0 ? 1 / (config.vibration_limit.value * 60) : 0)
    {
        this->_reader.apply_config(config);
    };
    std::string process(const std::string &gcode);

    private:
    GCodeReader _reader;
    double _min_time;  // minutes
    int _last_dir[2] {0, 0};
    double _dir_time[2] {0, 0};
};

}

#endif
