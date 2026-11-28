#ifndef slic3r_GCodeReader_hpp_
#define slic3r_GCodeReader_hpp_

#include "libslic3r.h"
#include <cmath>
#include <cstdlib>
#include <functional>
#include <string>
#include "PrintConfig.hpp"

namespace Slic3r {

class GCodeReader;
class GCodeReader {
    public:
    
    class GCodeLine {
        public:
        GCodeReader* reader;
        std::string raw;
        std::string cmd;
        std::string comment;
        std::map<char,std::string> args;
        
        GCodeLine(GCodeReader* _reader) : reader(_reader) {};
        
        bool has(char arg) const { return this->args.count(arg) > 0; };
        double get_float(char arg) const { return atof(this->args.at(arg).c_str()); };
        double new_X() const { return this->has('X') ? atof(this->args.at('X').c_str()) : this->reader->X; };
        double new_Y() const { return this->has('Y') ? atof(this->args.at('Y').c_str()) : this->reader->Y; };
        double new_Z() const { return this->has('Z') ? atof(this->args.at('Z').c_str()) : this->reader->Z; };
        double new_E() const { return this->has('E') ? atof(this->args.at('E').c_str()) : this->reader->E; };
        double new_F() const { return this->has('F') ? atof(this->args.at('F').c_str()) : this->reader->F; };
        double dist_X() const { return this->new_X() - this->reader->X; };
        double dist_Y() const { return this->new_Y() - this->reader->Y; };
        double dist_Z() const { return this->new_Z() - this->reader->Z; };
        double dist_E() const { return this->new_E() - this->reader->E; };
        double dist_XY() const {
            double x = this->dist_X();
            double y = this->dist_Y();
            return sqrt(x*x + y*y);
        };
        bool extruding() const { return this->cmd == "G1" && this->dist_E() > 0; };
        bool retracting() const { return this->cmd == "G1" && this->dist_E() < 0; };
        bool travel() const { return this->cmd == "G1" && !this->has('E'); };
        void set(char arg, std::string value);
    };
    typedef std::function<void(GCodeReader&, const GCodeLine&)> callback_t;
    
    double X, Y, Z, E, F;
    bool verbose;
    callback_t callback; 
    
    GCodeReader() : X(0), Y(0), Z(0), E(0), F(0), verbose(false), _extrusion_axis('E') {};
    void apply_config(const PrintConfigBase &config);
    void parse(const std::string &gcode, callback_t callback);
    void parse_stream(std::istream &gcode, callback_t callback);
    void parse_line(std::string line, callback_t callback);
    void parse_file(const std::string &file, callback_t callback);
    
    private:
    GCodeConfig _config;
    char _extrusion_axis;
};

} /* namespace Slic3r */

#endif /* slic3r_GCodeReader_hpp_ */
