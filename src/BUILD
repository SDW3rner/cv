# Bazel BUILD file for CV generation

# German CV target
genrule(
    name = "cv_de",
    srcs = [
        "cv_simon_werner.tex",
        "cv-style.cls",
    ] + glob(["../fonts/**"]) + glob(["../logos/**"]),
    outs = ["cv_simon_werner.pdf"],
    cmd = """
        # Create temp working directory with proper structure
        WORK=$$(mktemp -d)
        trap "rm -rf $$WORK" EXIT
        
        mkdir -p $$WORK/fonts $$WORK/logos
        
        # Copy all source files
        cp $(location cv_simon_werner.tex) $$WORK/
        cp $(location cv-style.cls) $$WORK/
        cp -r ../fonts/* $$WORK/fonts/ 2>/dev/null || true
        cp -r ../logos/* $$WORK/logos/ 2>/dev/null || true
        
        # Run xelatex
        cd $$WORK
        xelatex -interaction=nonstopmode -halt-on-error -output-directory=. cv_simon_werner.tex >/dev/null 2>&1 || true
        
        # Copy output
        cp cv_simon_werner.pdf $@
    """,
    tools = ["@bazel_tools//tools/bash:bash"],
    visibility = ["//visibility:public"],
)

# English CV target
genrule(
    name = "cv_en",
    srcs = [
        "cv_simon_werner_en.tex",
        "cv-style.cls",
    ] + glob(["../fonts/**"]) + glob(["../logos/**"]),
    outs = ["cv_simon_werner_en.pdf"],
    cmd = """
        # Create temp working directory with proper structure
        WORK=$$(mktemp -d)
        trap "rm -rf $$WORK" EXIT
        
        mkdir -p $$WORK/fonts $$WORK/logos
        
        # Copy all source files
        cp $(location cv_simon_werner_en.tex) $$WORK/
        cp $(location cv-style.cls) $$WORK/
        cp -r ../fonts/* $$WORK/fonts/ 2>/dev/null || true
        cp -r ../logos/* $$WORK/logos/ 2>/dev/null || true
        
        # Run xelatex
        cd $$WORK
        xelatex -interaction=nonstopmode -halt-on-error -output-directory=. cv_simon_werner_en.tex >/dev/null 2>&1 || true
        
        # Copy output
        cp cv_simon_werner_en.pdf $@
    """,
    tools = ["@bazel_tools//tools/bash:bash"],
    visibility = ["//visibility:public"],
)

# Convenience target to build both versions
filegroup(
    name = "cv_all",
    srcs = [
        ":cv_de",
        ":cv_en",
    ],
    visibility = ["//visibility:public"],
)

