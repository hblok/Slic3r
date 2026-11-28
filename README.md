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
* **support material**: pillars or grids, and tree supports (new in this fork, experimental:
  not yet tried on a printer);
* **conversion** between STL, OBJ, AMF, 3MF and POV formats;
* **auto-repair** of non-manifold meshes (and ability to re-export them);
* **SVG export** of slices;
* built-in **USB/serial** host controller, supporting **multiple simultaneous printers** each one with a spool queue;
* **OctoPrint integration** (send to printer);
* built-in **projector and host for DLP printers**;
* tool for **cutting meshes** in multiple solid parts with visual preview (also in batch using a grid);
* tool for **extruding 2.5D TIN meshes**.

### What language is it written in?

C++ (graphical interface with wxWidgets 3.2). Until November 2026 the
graphical interface and parts of the program were written in Perl; that program is in the
git history (tag `perl-final`).

### How to install?

On Debian 13, take the `.deb` from the
[releases](https://github.com/hblok/Slic3r/releases), if there is one:

```sh
sudo apt install ./slic3r_*_amd64.deb
slic3r                  # graphical interface
slic3r -g model.stl     # slice on the command line
slic3r --help
```

### How to build?

With [Bazel](https://bazel.build): install
[Bazelisk](https://github.com/bazelbuild/bazelisk) (it fetches the right Bazel) and

```sh
sudo apt install g++ libwxgtk3.2-dev libgl-dev libglu1-mesa-dev
bazel run //src:slic3r          # build and start the graphical interface
utils/make_dist.sh              # program, icons and printer profiles into build/dist-gui
```

Boost and the other libraries come with the build. `//src:slic3r-cli` is the command line
alone and needs only `g++`.

Tests (the GUI ones also need `xvfb xauth xdotool imagemagick libgl1-mesa-dri`):

```sh
bazel test //...
bazel test --build_tag_filters=-gui --test_tag_filters=-gui //...     # without the GUI
```

### Directory structure

* `package/`: the Debian package and the desktop entry
* `src/`: the C++ source of the `slic3r` executable
* `src/libslic3r/`: the slicing core
* `src/GUI/`: the graphical interface
* `src/test/`: tests, implemented with [Google Test](https://github.com/google/googletest)
* `src/third_party/`: libraries from other projects
* `utils/`: GUI test scripts, `make_dist.sh` and post-processing scripts
* `bazel/`: build rules for the system libraries and the tests under Xvfb

### Acknowledgements

The main author of Slic3r is Alessandro Ranellucci (@alranel, *Sound* in IRC, [@alranel](http://twitter.com/alranel) on Twitter), who started the project in 2011.

Joseph Lenox (`@lordofhyphens`, *LoH* in IRC, [@LenoxPlay](http://twitter.com/LenoxPlay) on Twitter) was co-maintainer of the original project.

Contributions by Henrik Brix Andersen, Vojtech Bubnik, Nicolas Dandrimont, Mark Hindess, Petr Ledvina, Y. Sapir, Mike Sheldrake, Kliment Yanev and numerous others. Original manual by Gary Hodgson. Slic3r logo designed by Corey Daniels, <a href="http://www.famfamfam.com/lab/icons/silk/">Silk Icon Set</a> designed by Mark James, stl and gcode file icons designed by Akira Yasuda.

### How can I invoke Slic3r using the command line?

Run `slic3r --help`. The original [manual page](https://manual.slic3r.org/advanced/command-line) has more detail.
