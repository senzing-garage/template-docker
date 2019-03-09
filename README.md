# docker-template

This repository shows best practices for creating a `docker-*` repository.

## Best practices

### README.md

1. Use [Markdown lint](https://dlaa.me/markdownlint/) to adhere to
    [Markdown rules](https://github.com/DavidAnson/markdownlint/blob/master/doc/Rules.md).

### Dockerfile

1. Follow [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).
1. Use a "linter" when applicable.
    1. [FROM: latest](https://www.fromlatest.io)
    1. [github.com/projectatomic/dockerfile_lint](https://github.com/projectatomic/dockerfile_lint)

        ```console
        docker run -it \
          --rm \
          --privileged \
          --volume $PWD:/root/ \
          projectatomic/dockerfile-lint \
            dockerfile_lint -f Dockerfile
        ```

    1. **Note:** Linters may erroneously report "ARG before FROM".

### Makefile

1. Use `make docker-build-base` occasionally to populate the docker image cache with layers that change infrequently.
1. Once a "base" has been created, use `make docker-build` to build during development and make final builds.
