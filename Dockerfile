ARG BASE_IMAGE=debian:13.2-slim@sha256:4bcb9db66237237d03b55b969271728dd3d955eaaa254b9db8a3db94550b1885
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2025-10-31

LABEL Name="senzing/template-docker" \
  Maintainer="support@senzing.com" \
  Version="1.3.6"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Install packages via apt.

RUN apt-get update \
  && apt-get -y --no-install-recommends install \
  less \
  python3 \
  python3-pip \
  python3-venv \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Activate virtual environment.

RUN python3 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"

# Install packages via PIP.

COPY pyproject.toml ./
RUN python3 -m pip install --upgrade pip
# example, skipping in template 
# as there is nothing to build
# && python3 -m pip install .

# Copy files from repository.

COPY ./rootfs /

# Make non-root container.

USER 1001

# Runtime execution.

WORKDIR /app
CMD ["/app/sleep-infinity.sh"]
