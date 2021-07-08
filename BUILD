#exports_files(["bin/argbash"])
sh_binary(
    name = "argbash",
    srcs = ["bin/argbash"],
    data = [":lib"],
    visibility = ["//visibility:public"],
    deps = ["@bazel_tools//tools/bash/runfiles"],
)

sh_library(
    name = "lib",
    srcs = glob(["src/*.m4"]),
    deps = [],
)
