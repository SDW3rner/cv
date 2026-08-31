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

### Building both German and English versions

The CV is now split into separate source files for better maintainability:

- **German version** (`cv_simon_werner.tex`): Build with:
  ```bash
  cd src
  xelatex -interaction=nonstopmode -halt-on-error -output-directory=../build cv_simon_werner.tex
  ```
  Output: [build/cv_simon_werner.pdf](build/cv_simon_werner.pdf)

- **English version** (`cv_simon_werner_en.tex`): Build with:
  ```bash
  cd src
  xelatex -interaction=nonstopmode -halt-on-error -output-directory=../build cv_simon_werner_en.tex
  ```
  Output: [build/cv_simon_werner_en.pdf](build/cv_simon_werner_en.pdf)

### Shared configuration

Common styling, formatting, and layout settings are consolidated in `cv-style.cls`. Both German and English versions inherit these shared settings, ensuring consistent appearance while allowing for language-specific content.

## Building with Bazel

This project includes Bazel build configuration for reproducible builds. Bazel ensures all dependencies are properly managed and builds are isolated.

### Prerequisites

- Install [Bazel](https://bazel.build/start)
- XeLaTeX must be installed and available in PATH

### Build targets

Build both German and English versions:
```bash
bazel build //src:cv_all
```

Build only German version:
```bash
bazel build //src:cv_de
```

Build only English version:
```bash
bazel build //src:cv_en
```

The compiled PDFs will be available in `bazel-bin/src/`:
- `cv_simon_werner.pdf` (German)
- `cv_simon_werner_en.pdf` (English)

### Project structure for Bazel

```
.
├── BUILD                    # Root Bazel configuration
├── WORKSPACE                # Bazel workspace definition
├── src/
│   ├── BUILD                # Targets for German and English CVs
│   ├── cv_simon_werner.tex  # German CV source
│   ├── cv_simon_werner_en.tex # English CV source
│   └── cv-style.cls         # Shared style file
├── build/
│   └── BUILD                # Output directory configuration
├── fonts/                   # Font files (included as dependencies)
└── logos/                   # Logo files (included as dependencies)
```