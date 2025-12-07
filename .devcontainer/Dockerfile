FROM mcr.microsoft.com/devcontainers/python:3.12-bullseye

# Update and install required packages as root
RUN apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    gzip \
    postgresql-client \
    golang-go \
    gettext \
    python3-dev \
    netcat-openbsd \
    util-linux \
    vim \
    bash-completion \
    yamllint \
    tmux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Overmind as root
RUN OVERMIND_VERSION="v2.5.1" && \
    OVERMIND_URL="https://github.com/DarthSim/overmind/releases/download/${OVERMIND_VERSION}/overmind-${OVERMIND_VERSION}-linux-amd64.gz" && \
    curl -L ${OVERMIND_URL} -o /tmp/overmind.gz && \
    gunzip /tmp/overmind.gz && \
    mv /tmp/overmind /usr/local/bin/overmind && \
    chmod +x /usr/local/bin/overmind

# Switch to vscode user for installing uv
USER vscode
WORKDIR /home/vscode

# Install uv as vscode user
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Ensure ~/.cargo/bin is in PATH
ENV PATH="/home/vscode/.cargo/bin:$PATH"

RUN curl -L https://github.com/axllent/mailpit/releases/download/v1.20.5/mailpit-linux-amd64.tar.gz | sudo tar -xz -C /usr/local/bin mailpit
