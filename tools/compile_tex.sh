#!/bin/bash
set -euo pipefail

# --- Begin Bazel Runfiles Library Boilerplate ---
set +e
f=bazel_tools/tools/bash/runfiles/runfiles.bash
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
  source "$0.runfiles/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  source "$(dirname "$0")/$f" 2>/dev/null || \
  source "$(dirname "$0")/$f.runfiles/$f" 2>/dev/null
set -e
# --- End Bazel Runfiles Library Boilerplate ---

# Read arguments passed by the macro
TEX_ARG="$1"
CLS_ARG="$2"
FONTS_ARG="$3"
LOGOS_ARG="$4"
OUTPUT_NAME="$5"
RELEASE_DIR=release

# Resolve absolute target locations
OUTPUT_DIR="${BUILD_WORKING_DIRECTORY:-$(pwd)}"
FINAL_PDF_PATH="$OUTPUT_DIR/$RELEASE_DIR/${OUTPUT_NAME}.pdf"

# Initialize temp workspace environment
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

mkdir -p "$WORK/$FONTS_ARG" "$WORK/$LOGOS_ARG"

# 1. Safely resolve and copy explicit LaTeX core files
TEX_FILE=$(rlocation "_main/$TEX_ARG")
CLS_FILE=$(rlocation "_main/$CLS_ARG")
cp "$TEX_FILE" "$WORK/"
cp "$CLS_FILE" "$WORK/"

# 2. Iterate through all execution runfiles to locate assets dynamically
# This completely bypasses directory-level symlink validation issues.
if [[ -f "${RUNFILES_MANIFEST_FILE:-}" ]]; then
  # Parse via manifest file if available (Windows/Fast links fallback)
  while read -r line; do
    runfile_path=$(echo "$line" | cut -d' ' -f1)
    abs_path=$(echo "$line" | cut -d' ' -f2-)
    
    if [[ "$runfile_path" == _main/"$FONTS_ARG"/* ]]; then
      cp "$abs_path" "$WORK/$FONTS_ARG/"
    elif [[ "$runfile_path" == _main/"$LOGOS_ARG"/* ]]; then
      cp "$abs_path" "$WORK/$LOGOS_ARG/"
    fi
  done < "$RUNFILES_MANIFEST_FILE"
else
  # Fallback: Parse via standard structural filesystem runfiles tree traversal
  find "${RUNFILES_DIR:-$0.runfiles}/_main/$FONTS_ARG" -type f -o -type l 2>/dev/null | while read -r file; do
    cp "$file" "$WORK/$FONTS_ARG/"
  done
  find "${RUNFILES_DIR:-$0.runfiles}/_main/$LOGOS_ARG" -type f -o -type l 2>/dev/null | while read -r file; do
    cp "$file" "$WORK/$LOGOS_ARG/"
  done
fi

# 3. Change directory and execute TeX compilation
cd "$WORK"
TEX_BASENAME=$(basename "$TEX_FILE")
PDF_BASENAME="${TEX_BASENAME%.tex}.pdf"

echo "Compiling LaTeX file: $TEX_BASENAME ..."
xelatex -interaction=nonstopmode -halt-on-error -output-directory=. "$TEX_BASENAME"
xelatex -interaction=nonstopmode -halt-on-error -output-directory=. "$TEX_BASENAME" # second run to resolve links

if [ ! -f "$PDF_BASENAME" ]; then
  echo "ERROR: xelatex completed but did not produce $PDF_BASENAME" >&2
  exit 1
fi

# Move file back to workspace
mkdir -p "$OUTPUT_DIR/$RELEASE_DIR"
cp "$PDF_BASENAME" "$FINAL_PDF_PATH"
echo "Success: PDF created at $FINAL_PDF_PATH"
