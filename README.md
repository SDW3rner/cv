# CV

This repository contains a LaTeX-based CV template and source for a German/English resume.

## Build instructions

The CV is built with XeLaTeX (or LuaLaTeX) because the template uses OpenType fonts.

1. Make sure the required fonts are available in the [fonts](fonts) directory.
2. From the repository root, create the build directory if needed and run the build from the source directory:

   ```bash
   mkdir -p build
   cd src
   xelatex -interaction=nonstopmode -halt-on-error -output-directory=../build cv_simon_werner.tex
   ```

3. The generated PDF will be written to [build/cv_simon_werner.pdf](build/cv_simon_werner.pdf).

### Switching languages

- German (default): keep the document class line as `\documentclass[deutsch]{cv-style}`.
- English: change it to `\documentclass{cv-style}`.