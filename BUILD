# Root BUILD file for CV project
load("//:tools/tex.bzl", "create_pdf_from_tex")

# Convenience target to build both versions
filegroup(
    name = "cv_all",
    srcs = [
        ":cv_de",
        ":cv_en",
    ],
    visibility = ["//visibility:public"],
)



# German CV target
create_pdf_from_tex(
    name = "cv_de",
    tex_file = "src/cv_simon_werner.tex",
    cls_file = "src/cv-style.cls",
)

# English CV target
create_pdf_from_tex(
    name = "cv_en",
    tex_file = "src/cv_simon_werner_en.tex",
    cls_file = "src/cv-style.cls",
)
