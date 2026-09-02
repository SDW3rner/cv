# Build CV PDFs using Bazel and XeLaTeX
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Build tools
    curl \
    git \
    git-lfs \
    ca-certificates \
    gnupg \
    # LaTeX and fonts
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-latex-extra \
    texlive-lang-german \
    fonts-roboto \
    # Utilities
    zip \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# Install Bazelisk (modern Bazel version manager)
RUN curl -fsSL https://github.com/bazelbuild/bazelisk/releases/download/v1.20.0/bazelisk-linux-amd64 \
    -o /usr/local/bin/bazel && \
    chmod +x /usr/local/bin/bazel

# Install Buildifier (Bazel BUILD file formatter)
RUN curl -fsSL https://github.com/bazelbuild/buildtools/releases/download/v7.1.1/buildifier-linux-amd64 \
    -o /usr/local/bin/buildifier && \
    chmod +x /usr/local/bin/buildifier

# Copy zsh configuration
COPY .devcontainer/.zshrc /root/.zshrc

# Set working directory
WORKDIR /workspace

# Default command
CMD ["bazel", "build", "//:cv_all"]
