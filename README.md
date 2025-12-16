# template-docker

If you are beginning your journey with [Senzing],
please start with [Senzing Quick Start guides].

You are in the [Senzing Garage] where projects are "tinkered" on.
Although this GitHub repository may help you understand an approach to using Senzing,
it's not considered to be "production ready" and is not considered to be part of the Senzing product.
Heck, it may not even be appropriate for your application of Senzing!

## Synopsis

This section should give 4-5 sentences on what the artifacts in this repository do.

## Overview

This section should be replaced with real "**Overview**" content after initial repository creation.

This repository shows best practices for creating a `docker-*` repository.
See [best practices].

### Contents

1. [Preamble]
   1. [Legend]
   1. [Expectations]
1. [Demonstrate using Docker]
   1. [Prerequisites for Docker]
   1. [Database support]
   1. [External database]
   1. [Run Docker container]
1. [Configuration]
1. [References]

## Preamble

At [Senzing], we strive to create GitHub documentation in a
"[don't make me think]" style. For the most part, instructions are copy and paste.
Whenever thinking is needed, it's marked with a "thinking" icon :thinking:.
Whenever customization is needed, it's marked with a "pencil" icon :pencil2:.
If the instructions are not clear, please let us know by opening a new
[Documentation issue] describing where we can improve. Now on with the show...

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps there are some choices to be made.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

### Expectations

- **Space:** This repository and demonstration require 6 GB free disk space.
- **Time:** Budget 40 minutes to get the demonstration up-and-running, depending on CPU and network speeds.
- **Background knowledge:** This repository assumes a working knowledge of:
  - [Docker]

## Demonstrate using Docker

### Prerequisites for Docker

:thinking: The following tasks need to be complete before proceeding.
These are "one-time tasks" which may already have been completed.

1. The following software programs need to be installed:
   1. [docker]
1. [Install Senzing using Docker]
1. [Configure Senzing database using Docker]

### Database support

:thinking: **Optional:** Some databases need additional support.
For other databases, these steps may be skipped.

1. **Db2:** See [Support Db2] instructions to set `SENZING_OPT_IBM_DIR_PARAMETER`.
1. **MS SQL:** See [Support MS SQL] instructions to set `SENZING_OPT_MICROSOFT_DIR_PARAMETER`.

### External database

:thinking: **Optional:** Use if storing data in an external database.
If not specified, the internal SQLite database will be used.

1. :pencil2: Specify database.
   Example:

   ```console
   export DATABASE_PROTOCOL=postgresql
   export DATABASE_USERNAME=postgres
   export DATABASE_PASSWORD=postgres
   export DATABASE_HOST=senzing-postgresql
   export DATABASE_PORT=5432
   export DATABASE_DATABASE=G2
   ```

1. Construct Database URL.
   Example:

   ```console
   export SENZING_DATABASE_URL="${DATABASE_PROTOCOL}://${DATABASE_USERNAME}:${DATABASE_PASSWORD}@${DATABASE_HOST}:${DATABASE_PORT}/${DATABASE_DATABASE}"
   ```

1. Construct parameter for `docker run`.
   Example:

   ```console
   export SENZING_DATABASE_URL_PARAMETER="--env SENZING_DATABASE_URL=${SENZING_DATABASE_URL}"
   ```

### Run Docker container

Although the `Docker run` command looks complex,
it accounts for all of the optional variations described above.
Unset `*_PARAMETER` environment variables have no effect on the
`docker run` command and may be removed or remain.

1. Run Docker container.
   Example:

   ```console
   sudo docker run \
     --interactive \
     --rm \
     --tty \
     ${SENZING_DATABASE_URL_PARAMETER} \
     ${SENZING_OPT_IBM_DIR_PARAMETER} \
     ${SENZING_OPT_MICROSOFT_DIR_PARAMETER} \
     senzing/template
   ```

1. For more examples of use, see [Examples of Docker].

## Configuration

Configuration values specified by environment variable or command line parameter.

- **[SENZING_DATABASE_URL]**
- **[SENZING_DEBUG]**

## References

1. [Development]
1. [Errors]
1. [Examples]
1. Related artifacts:
   1. [DockerHub]
   1. [Helm Chart]

[best practices]: docs/best-practices.md
[Configuration]: #configuration
[Configure Senzing database using Docker]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/configure-senzing-database-using-docker.md
[Database support]: #database-support
[Demonstrate using Docker]: #demonstrate-using-docker
[Development]: docs/development.md
[Docker]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/docker.md
[DockerHub]: https://hub.docker.com/r/senzing/template-docker
[Documentation issue]: https://github.com/senzing-garage/template-docker/issues/new?template=documentation_request.md
[don't make me think]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/dont-make-me-think.md
[Errors]: docs/errors.md
[Examples of Docker]: docs/examples.md#examples-of-docker
[Examples]: docs/examples.md
[Expectations]: #expectations
[External database]: #external-database
[Helm Chart]: https://github.com/senzing-garage/charts/tree/main/charts/template-docker
[Install Senzing using Docker]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/install-senzing-using-docker.md
[Legend]: #legend
[Preamble]: #preamble
[Prerequisites for Docker]: #prerequisites-for-docker
[References]: #references
[Run Docker container]: #run-docker-container
[Senzing Garage]: https://github.com/senzing-garage
[Senzing Quick Start guides]: https://docs.senzing.com/quickstart/
[SENZING_DATABASE_URL]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_database_url
[SENZING_DEBUG]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#senzing_debug
[Senzing]: https://senzing.com/
[Support Db2]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/support-db2.md
[Support MS SQL]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/support-mssql.md
