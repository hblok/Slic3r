"""wxWidgets as the system has it (Debian: libwxgtk3.2-dev), described by wx-config."""

_COMPONENTS = "net,gl,html,aui,adv,core,base"

def _wxwidgets_impl(repository):
    config = repository.which("wx-config")
    if not config:
        fail("wx-config not found. The GUI needs libwxgtk3.2-dev (README.md); " +
             "without it: --build_tag_filters=-gui --test_tag_filters=-gui")

    def flags(what):
        result = repository.execute([config, what, _COMPONENTS])
        if result.return_code:
            fail("wx-config %s failed: %s" % (what, result.stderr))
        return [flag for flag in result.stdout.strip().split(" ") if flag]

    includes, defines, copts = [], [], []
    for flag in flags("--cxxflags"):
        if flag.startswith("-I"):
            name = "include%d" % len(includes)
            repository.symlink(flag[2:], name)
            includes.append(name)
        elif flag.startswith("-D"):
            defines.append(flag[2:])
        else:
            copts.append(flag)

    repository.file("BUILD.bazel", """load("@rules_cc//cc:cc_library.bzl", "cc_library")

cc_library(
    name = "wxwidgets",
    hdrs = glob(["include*/**/*.h"]),
    defines = {defines},
    includes = {includes},
    linkopts = {linkopts},
    visibility = ["//visibility:public"],
)
""".format(defines = defines, includes = includes, linkopts = flags("--libs") + copts))

system_wxwidgets = repository_rule(
    implementation = _wxwidgets_impl,
    local = True,  # look again when the system's packages may have changed
)
