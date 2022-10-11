ARG BASE_IMAGE=debian:11.5-slim@sha256:b46fc4e6813f6cbd9f3f6322c72ab974cc0e75a72ca02730a8861e98999875c7
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2022-10-11

LABEL Name="senzing/template" \
      Maintainer="support@senzing.com" \
      Version="1.3.2"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

RUN apt-get update \
 && apt-get -y install \
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
