/// An object for the tests of the dialogs that show one.
#ifndef OBJECT_FIXTURE_HPP
#define OBJECT_FIXTURE_HPP

#include "Model.hpp"
#include "TriangleMesh.hpp"

/// A 20 x 20 x 10 mm box as the only object of its model.
struct BoxObject {
    Slic3r::Model model;
    Slic3r::ModelObject* object {nullptr};
    BoxObject() {
        Slic3r::TriangleMesh mesh {Slic3r::TriangleMesh::make_cube(20, 20, 10)};
        mesh.repair();
        object = model.add_object();
        object->add_volume(mesh);
        model.add_default_instances();
    }
};

#endif
