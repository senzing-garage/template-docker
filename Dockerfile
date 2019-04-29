ARG BASE_IMAGE=senzing/senzing-base
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2019-04-12

LABEL Name="senzing/template" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# XXX

RUN mkdir -p /opt/senzing

# Copy files from repository.

COPY ./rootfs /

# Runtime execution.

WORKDIR /app
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["/app/sleep-infinity.sh"]
