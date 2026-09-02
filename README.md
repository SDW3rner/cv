# CV

This repository contains a LaTeX-based CV template and source for a German/English resume.

## Building with Bazel

This project includes Bazel build configuration for reproducible builds. Bazel ensures all dependencies are properly managed and builds are isolated.

### Prerequisites

- Install [Bazel](https://bazel.build/start)
- XeLaTeX must be installed and available in PATH for Bazel to build the PDFs

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