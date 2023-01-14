FROM mcr.microsoft.com/devcontainers/base:bullseye

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends python3-pip \
    && pip install --no-input pre-commit
