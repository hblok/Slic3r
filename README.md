![](var/Slic3r_128px.png) Slic3r [![build](https://github.com/hblok/Slic3r/actions/workflows/build.yml/badge.svg)](https://github.com/hblok/Slic3r/actions/workflows/build.yml)
======

> **This is an unofficial fork** of [Slic3r](https://github.com/slic3r/Slic3r), modified and
> maintained independently since November 2026, starting from upstream commit `026c1380`.
> It is not affiliated with or endorsed by the original authors. Please report problems
> here, not upstream.

The aim is to keep Slic3r building on current systems and to add useful slicing features
developed in recent years. Work is at an early stage: see the [plan](plan/README.md).
There are no releases yet.

### AI disclosure

This fork is maintained and extended with substantial help from AI coding assistants
(Anthropic's Claude Code), including code, tests and documentation. AI-assisted commits
carry a `Co-Authored-By` trailer. The history up to `026c1380` is the upstream project's.

### License

[GNU Affero General Public License v3](LICENSE), the same as the original.

### So, what's this Slic3r?

Slic3r is mainly a **toolpath generator** for 3D printers: it reads 3D models (STL, OBJ, AMF, 3MF) and it converts them into **G-code** instructions for 3D printers. But it does much more than that, see the [features list](#features) below.

Slic3r was born in **2011** within the RepRap community and thanks to its high configurability became the swiss-army knife for 3D printing. It served as a platform for implementing several **new (experimental) ideas that later became technology standards**, such as multiple extruders, brim, variable-height layers, per-object settings, modifiers, post-processing scripts, G-code macros and more. Despite being based on volunteer efforts, Slic3r is still pushing the boundaries of 3D printing.

Slic3r is:

* **Open:** it is totally **open source** and it's **independent from any commercial company** or printer manufacturer. We want to keep 3D printing open and free.
* **Compatible:** it supports all the known G-code dialects (Marlin, Repetier, Mach3, LinuxCNC, Machinekit, Smoothie, Makerware, Sailfish).
* **Advanced:** many configuration options allow for fine-tuning and full control. While novice users often need just few options, Slic3r is mostly used by advanced users.
* **Community-driven:** new features or issues are discussed openly. Help improve it!
* **Robust:** the codebase includes more than 1,000 unit and regression tests, collected in 6 years of development.
* **Modular:** the core of Slic3r is libslic3r, a C++ library that provides a granular API and reusable components.
* **Embeddable:** a complete and powerful command line interface allows Slic3r to be used from the shell or integrated with server-side applications.
* **Powerful:** see the list below!

See [slic3r.org](https://slic3r.org/), the original project's homepage, for background.

### <a name="features"></a>Features

(Most of these are also available in the command line interface.)

* **G-code generation** for FFF/FDM printers;
* **conversion** between STL, OBJ, AMF, 3MF and POV formats;
* **auto-repair** of non-manifold meshes (and ability to re-export them);
* **SVG export** of slices;
* built-in **USB/serial** host controller, supporting **multiple simultaneous printers** each one with a spool queue;
* **OctoPrint integration** (send to printer);
* built-in **projector and host for DLP printers**;
* tool for **cutting meshes** in multiple solid parts with visual preview (also in batch using a grid);
* tool for **extruding 2.5D TIN meshes**.

### What language is it written in?

C++ (C++11 core, C++14 graphical interface with wxWidgets 3.2). Until November 2026 the
graphical interface and parts of the program were written in Perl; that program is in the
git history (tag `perl-final`).

### How to install?

No packages are provided yet. It builds from source on Debian 13.

```sh
sudo apt install cmake g++ libboost-dev libboost-thread-dev libboost-filesystem-dev libboost-nowide-dev \
  libwxgtk3.2-dev libgl-dev libglu1-mesa-dev
cmake -S src -B build-gui -DCMAKE_BUILD_TYPE=Release -DEnable_GUI=ON
cmake --build build-gui -j$(nproc) --target slic3r
./build-gui/slic3r                  # graphical interface
./build-gui/slic3r -g model.stl     # slice on the command line
./build-gui/slic3r --help
```

`utils/make_dist.sh` puts the program, its icons and the printer profiles into a directory
you can copy. For the command line alone, leave out the wxWidgets and OpenGL packages and
`-DEnable_GUI=ON`.

Tests (see [CLAUDE.md](CLAUDE.md)):

```sh
cmake -S src -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(nproc)
ctest --test-dir build -L quick --output-on-failure        # a few seconds
cmake --build build-gui -j$(nproc)                         # also builds the GUI unit tests
ctest --test-dir build-gui -L gui -j5 --output-on-failure  # GUI under Xvfb; needs xvfb xauth xdotool imagemagick
```

### Directory structure

* `package/`: Linux desktop entry (packaging is to be rebuilt)
* `src/`: the C++ source of the `slic3r` executable and the CMake definition file for compiling it
* `src/libslic3r/`: the slicing core
* `src/GUI/`: the graphical interface
* `src/test/`: tests, implemented with [Catch2](https://github.com/catchorg/Catch2)
* `src/third_party/`: libraries from other projects
* `utils/`: GUI test scripts, `make_dist.sh` and post-processing scripts

### Acknowledgements

The main author of Slic3r is Alessandro Ranellucci (@alranel, *Sound* in IRC, [@alranel](http://twitter.com/alranel) on Twitter), who started the project in 2011.

Joseph Lenox (`@lordofhyphens`, *LoH* in IRC, [@LenoxPlay](http://twitter.com/LenoxPlay) on Twitter) was co-maintainer of the original project.

Contributions by Henrik Brix Andersen, Vojtech Bubnik, Nicolas Dandrimont, Mark Hindess, Petr Ledvina, Y. Sapir, Mike Sheldrake, Kliment Yanev and numerous others. Original manual by Gary Hodgson. Slic3r logo designed by Corey Daniels, <a href="http://www.famfamfam.com/lab/icons/silk/">Silk Icon Set</a> designed by Mark James, stl and gcode file icons designed by Akira Yasuda.

### How can I invoke Slic3r using the command line?

Run `slic3r --help`. The original [manual page](https://manual.slic3r.org/advanced/command-line) has more detail.
