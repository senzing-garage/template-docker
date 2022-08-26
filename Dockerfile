ARG BASE_IMAGE=debian:11.4-slim@sha256:68c1f6bae105595d2ebec1589d9d476ba2939fdb11eaba1daec4ea826635ce75
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2022-08-25

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
