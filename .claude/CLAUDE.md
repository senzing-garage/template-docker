# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Docker image template repository for Senzing. It serves as a starting point for creating Docker-based repositories in the senzing-garage organization.

## Build Commands

```bash
# Build Docker image (preferred)
make docker-build

# Alternative: Build directly with docker
docker build --tag senzing/template-docker .

# Clean up Docker images
make clean

# List all make targets
make help
```

## Repository Structure

- `Dockerfile` - Main Docker image definition (Debian-based with Python 3)
- `Makefile` - Build automation
- `rootfs/` - Files copied into the container at `/`
  - `rootfs/app/healthcheck.sh` - Container health check script
  - `rootfs/app/container-test.sh` - Container test script
  - `rootfs/app/sleep-infinity.sh` - Default entrypoint
- `pyproject.toml` - Python project metadata
- `docs/` - Documentation including development guide and best practices

## Important Conventions

### Dockerfile Updates

When modifying the Dockerfile, always update the `REFRESHED_AT` environment variable date. A CI workflow (`verify-dockerfile-refreshed-at-updated.yaml`) enforces this.

### Version Management

Version is tracked in two places that must stay in sync:

- `Dockerfile` LABEL Version
- `pyproject.toml` version field

### Changelog Format

Uses [Keep a Changelog](https://keepachangelog.com) format with [CommonMark](https://commonmark.org/) and reference-style links. Follows [Semantic Versioning](https://semver.org/).

## CI/CD

Pull requests trigger:

- `docker-build-container.yaml` - Builds and tests the Docker image
- `verify-dockerfile-refreshed-at-updated.yaml` - Ensures REFRESHED_AT is updated
- `spellcheck.yaml` - Runs cspell for spelling checks
- `lint-workflows.yaml` - Lints GitHub Actions workflows

Most workflows use reusable actions from `senzing-factory/build-resources` and `senzing-factory/github-action-docker-buildx-build`.

## Linting

- YAML linting config: `.github/linters/.yaml-lint.yml`
- Spellcheck dictionary: `.vscode/cspell.json`
