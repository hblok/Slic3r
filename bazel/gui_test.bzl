"""A C++ test that needs a display."""

load("@rules_cc//cc:cc_binary.bzl", "cc_binary")
load("@rules_shell//shell:sh_test.bzl", "sh_test")

def gui_test(name, srcs, deps, data = [], size = "small"):
    """Google Test cases run inside a wxWidgets application under Xvfb.

    Args:
      name: the test target.
      srcs: the test's sources.
      deps: the target it tests.
      data: files the test reads.
      size: as for any test.
    """
    cc_binary(
        name = name + "_program",
        testonly = True,
        srcs = srcs,
        data = data,
        tags = ["gui"],
        deps = deps + ["//src/test/GUI:gui_test_main"],
    )
    sh_test(
        name = name,
        size = size,
        srcs = ["//bazel:under_xvfb.sh"],
        args = ["$(rootpath :%s_program)" % name],
        data = [":%s_program" % name] + data,
        tags = ["gui"],
    )
