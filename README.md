# docker-template

## Overview

This repository shows best practices for creating a `docker-*` repository.

### Contents

1. [Expectations](#expectations)
    1. [Space](#space)
    1. [Time](#time)
    1. [Background knowledge](#background-knowledge)
1. [Demonstrate](#demonstrate)
    1. [Build docker image](#build-docker-image)
    1. [Create SENZING_DIR](#create-senzing_dir)
    1. [Configuration](#configuration)
    1. [Run docker container](#run-docker-container)
1. [Develop](#develop)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build docker image for development](#build-docker-image-for-development)

## Best practices

### README.md

1. Use [Markdown lint](https://dlaa.me/markdownlint/) to adhere to
    [Markdown rules](https://github.com/DavidAnson/markdownlint/blob/master/doc/Rules.md).

### Dockerfile

1. Use best practices:
    1. Docker's [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).
    1. Project Atomic's [Container Best practices](http://docs.projectatomic.io/container-best-practices).
1. Use "lint" when applicable.
    1. Online linter: [FROM: latest](https://www.fromlatest.io)
    1. GitHub [projectatomic/dockerfile_lint](https://github.com/projectatomic/dockerfile_lint) using Docker

        ```console
        sudo docker run -it \
          --rm \
          --privileged \
          --volume $PWD:/root/ \
          projectatomic/dockerfile-lint \
            dockerfile_lint -f Dockerfile
        ```

    1. **Note:** Linters may erroneously report "ARG before FROM" which is supported as of
        Enterprise Edition [17.06.01](https://docs.docker.com/engine/release-notes/#17061-ee-1) and
        Community Edition [17.05.0](https://docs.docker.com/engine/release-notes/#17050-ce).

### Makefile

1. Modifications:
    1. Change following value to appropriate Docker tag.

        ```make
        DOCKER_IMAGE_NAME := senzing/template
        ```

1. Use `make docker-build-base` occasionally to populate the docker image cache with layers that change infrequently.
1. Once a "base" has been created, use `make docker-build` to build during development and make final builds.

### CONTRIBUTING.md

1. Modifications:
    1. Change following value to appropriate Git repository name.

        ```markdown
        export GIT_REPOSITORY=docker-template
        ```

## Expectations

### Space

This repository and demonstration require 6 GB free disk space.

### Time

Budget 40 minutes to get the demonstration up-and-running, depending on CPU and network speeds.

### Background knowledge

This repository assumes a working knowledge of:

1. [Docker](https://github.com/Senzing/knowledge-base/blob/master/WHATIS/docker.md)

## Demonstrate

### Build docker image

1. Using `make`:

    ```console
    sudo docker build --tag senzing/template https://github.com/senzing/docker-template.git
    ```

### Create SENZING_DIR

1. If `/opt/senzing` directory is not on local system, visit
   [HOWTO - Create SENZING_DIR](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/create-senzing-dir.md).

### Configuration

* **SENZING_DEBUG** -
  Enable debug information. Values: 0=no debug; 1=debug. Default: 0.
* **SENZING_DIR** -
  Location of Senzing libraries. Default: "/opt/senzing".  

### Run docker container

1. Using Docker:

    ```console
    sudo docker run \
      --interactive \
      --rm \
      --tty \
      senzing/template
    ```

## Develop

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-git.md)
1. [make](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-make.md)
1. [docker](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/install-docker.md)

### Clone repository

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=senzing
    export GIT_REPOSITORY=docker-template
    ```

1. Follow steps in [clone-repository](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/clone-repository.md) to install the Git repository.

1. After the repository has been cloned, be sure the following are set:

    ```console
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

### Build docker image for development

1. Option #1 - Using docker command and GitHub.

    ```console
    sudo docker build --tag senzing/template https://github.com/senzing/docker-template.git
    ```

1. Option #2 - Using docker command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo docker build --tag senzing/template .
    ```

1. Option #3 - Using make command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo make docker-build
    ```
