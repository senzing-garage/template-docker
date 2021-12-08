ARG BASE_IMAGE=debian:10.11@sha256:9a1f494bb52e5d18e2dfb0fd6e59dbfe69aae9feecff1b246ad69984fbe25772
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2021-12-07

LABEL Name="senzing/template" \
      Maintainer="support@senzing.com" \
      Version="1.3.1"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Install packages via apt.

# Copy files from repository.

COPY ./rootfs /

# Make non-root container.

USER 1001

# Runtime execution.

WORKDIR /app
CMD ["/app/sleep-infinity.sh"]
