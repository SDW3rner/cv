"Create a PDF file from a TEX file"
load("@rules_shell//shell:sh_binary.bzl", "sh_binary")

def create_pdf_from_tex(
    name: str,
    tex_file: str,
    cls_file: str,
    fonts_dir: str = "fonts",
    logos_dir: str = "logos",
) -> None:
    """Creates a Bazel sh_binary to build and output a LaTeX PDF to the workspace."""
    
    package_path = native.package_name()
    prefix = package_path + "/" if package_path else ""

    sh_binary(
        name = name,
        srcs = ["//:tools/compile_tex.sh"],  # Path to your shell script
        data = [
            tex_file,
            cls_file,
        ] + native.glob([fonts_dir + "/**"]) + native.glob([logos_dir + "/**"]),
        deps = [
            "@bazel_tools//tools/bash/runfiles",  # Adds the native path lookup library
        ],
        args = [
            prefix + tex_file,
            prefix + cls_file,
            prefix + fonts_dir,
            prefix + logos_dir,
            name,
        ],
        visibility = ["//visibility:public"],
    )

