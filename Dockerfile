ARG BASE_IMAGE=debian:11.11-slim@sha256:6d3c63184632046054ae709964befc943ecffa140adc697ca955a10002a79c08
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-06-24

LABEL Name="senzing/template-docker" \
  Maintainer="support@senzing.com" \
  Version="1.3.4"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Install packages via apt.

RUN apt-get update \
  && apt-get -y install \
  less \
  python3 \
  python3-pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install packages via PIP.

COPY requirements.txt ./
RUN pip3 install --upgrade pip \
  && pip3 install -r requirements.txt \
  && rm requirements.txt

# Install packages via apt.

# Copy files from repository.

COPY ./rootfs /

# Make non-root container.

USER 1001

# Runtime execution.

WORKDIR /app
CMD ["/app/sleep-infinity.sh"]
