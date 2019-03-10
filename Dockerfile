ARG BASE_CONTAINER=alpine:3.9
FROM ${BASE_CONTAINER}

ENV REFRESHED_AT=2019-03-09

LABEL Name="senzing/template" \
      Version="1.0.0"

# Alpine package repository: https://pkgs.alpinelinux.org/packages

CMD ["/bin/ash"]