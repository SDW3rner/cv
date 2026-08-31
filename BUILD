# Root BUILD file for CV project

filegroup(
    name = "all_targets",
    srcs = [
        "//src:cv_all",
        "//build:cv_pdfs",
    ],
    visibility = ["//visibility:public"],
)

alias(
    name = "cv",
    actual = "//src:cv_all",
    visibility = ["//visibility:public"],
)
