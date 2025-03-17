# DockerComposeExample

| **Category** | **Status' and Links**                                                                                                                                                             |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| General      | [![][general_maintenance_y_img]][general_maintenance_y_lnk] [![][general_semver_pic]][general_semver_link] [![][general_license_img]][general_license_lnk]                        |
| CD/CI        | [![][cicd_codestyle_img]][cicd_codestyle_lnk] [![][codecov_img]][codecov_lnk]                                                                                                     |
| PyPI         | [![][pypi_release_img]][pypi_release_lnk] [![][pypi_py_versions_img]][pypi_py_versions_lnk] [![][pypi_format_img]][pypi_format_lnk] [![][pypi_downloads_img]][pypi_downloads_lnk] |
| Github       | [![][gh_issues_img]][gh_issues_lnk] [![][gh_language_img]][gh_language_lnk] [![][gh_last_commit_img]][gh_last_commit_lnk]                                                         |

Docker example and template to illustrate:

- Docker Compose with two services
  - API (fastAPI)
  - Database (mysql)
- CI/CD
- Usage of PowerShell scripts to automate tasks

# FAQ

## What is the relationship between the Docker file and the docker-compose.yaml file?

The Dockerfile and the docker-compose.yaml file serve different but complementary roles in containerized application
development:

- **Dockerfile**:

  - Contains a set of instructions to build a Docker image.
  - Defines the base image, installs dependencies, copies files, and specifies the command to run when a container
    starts.
  - Acts as a blueprint for creating a single container image.

- **docker-compose.yaml**:

  - Orchestrates multiple containers (services) together, specifying how they should run and interact.
  - Can reference images built from Dockerfiles (using a build directive) or pre-built images from a registry.
  - Defines configurations such as environment variables, ports, volumes, and dependencies among services.

**Relationship:**

- The Dockerfile builds the image used by one or more services defined in docker-compose.yaml.
- In docker-compose.yaml, you can use the `build` key to point to a Dockerfile (and context) that should be built before
  starting a service, or you can directly reference an already-built image.
- Together, they let you define how to construct your container images (Dockerfile) and then deploy and connect them (
  docker-compose.yaml).

This separation allows you to manage the build process and the runtime orchestration independently.

## Does this mean that if there is no Docker file, it will not build and image?

Not exactly. If you don't have a Dockerfile and you don't specify a build context in your docker-compose.yml file,
Docker Compose will simply pull and run the image specified in the image field (for example, from Docker Hub). In other
words, Docker Compose only builds an image when you include a build section (which usually points to a Dockerfile). If
no Dockerfile is provided and you rely solely on pre-built images, no image building occurs.

## Is it correct to say that if I use and image in the docker-compose service, then I do not need a build section?

Yes, that's correct. If you specify an image (for example, `image: mysql:8.0.34`) in your docker-compose service, Docker
Compose will pull that image from the registry (if it's not already available locally) and run it. In that case, you
don't need a build section because you're not building a custom image from a Dockerfile.

## What is the consequence of not having a built section in the docker-compose file and also no Docker file?

If you don't have a build section in your docker-compose file and there's no Dockerfile provided, Docker Compose will
not build any custom image. Instead, it will rely solely on the pre-built image specified in the service's image field.
This means:

- **No Customization:** You can't modify the image by adding extra software, changing configuration, or copying files
  into it. You're entirely dependent on the externally provided image as it is.
- **Automatic Pulling:** If the specified image isn't available locally, Docker Compose will pull it from the container
  registry (such as Docker Hub).
- **Limited Flexibility:** If you need to change the runtime environment or dependencies, you'll have to update or
  rebuild the image externally rather than via your Compose configuration.

In summary, without a build section and a Dockerfile, you're locked into using the exact image from the registry without
any modifications.

## What is the consequence if I have specifies an image in the docker-compose.yaml file, for instance "image: mysql:8.3.0" and I have a Docker file with "FROM python:3.10-slim"

If you specify an image in your docker-compose.yaml (e.g. `image: mysql:8.3.0`) while also providing a Dockerfile that
starts with a different base image (e.g. `FROM python:3.10-slim`), you create a conflicting configuration. Here’s what
happens:

- **With a Build Section Present:**\
  If your service in docker-compose.yaml includes a build section (or if Docker Compose detects a Dockerfile in the
  context) along with an image key, Docker Compose will build an image using your Dockerfile and then tag it with the
  image name you specified. In this case, your resulting image will be built from `python:3.10-slim` even though you’re
  tagging it as `mysql:8.3.0`. That means the container won’t have MySQL installed—leading to runtime errors (for
  example, “mysqld: not found”).

- **Without a Build Section:**\
  If you only specify an image and no build section, Docker Compose will pull the pre-built image (in this example, the
  official `mysql:8.3.0` image) from a registry. In that scenario, your Dockerfile is ignored entirely.

**In summary:**\
If you mix an `image` specification with a Dockerfile that’s based on a different base image, and if Docker Compose uses
your Dockerfile (because a build section is present or inferred), your container will be built using that
Dockerfile—even though it is tagged with the name of the image you specified. This can lead to a container that doesn’t
behave as expected (for example, it won’t have the MySQL server if your Dockerfile starts with Python).

The key is to decide whether you want to use a pre-built image (with no Dockerfile) or build your own custom image (with
a Dockerfile). You should not mix a Dockerfile that produces one type of container (Python-based) with an image tag that
suggests something else (MySQL).

[cicd_codestyle_img]: https://img.shields.io/badge/code%20style-black-000000.svg "Black"
[cicd_codestyle_lnk]: https://github.com/psf/black "Black"
[codecov_img]: https://img.shields.io/codecov/c/gh/hendrikdutoit/dockercomposeexample "CodeCov"
[codecov_lnk]: https://app.codecov.io/gh/hendrikdutoit/dockercomposeexample "CodeCov"
[general_license_img]: https://img.shields.io/pypi/l/dockercomposeexample "License"
[general_license_lnk]: https://github.com/hendrikdutoit/dockercomposeexample/blob/master/LICENSE "License"
[general_maintenance_y_img]: https://img.shields.io/badge/Maintenance%20Intended-%E2%9C%94-green.svg?style=flat-square "Maintenance - intended"
[general_maintenance_y_lnk]: http://unmaintained.tech/ "Maintenance - intended"
[general_semver_link]: https://semver.org/ "Sentic Versioning - 2.0.0"
[general_semver_pic]: https://img.shields.io/badge/Semantic%20Versioning-2.0.0-brightgreen.svg?style=flat-square "Sentic Versioning - 2.0.0"
[gh_issues_img]: https://img.shields.io/github/issues-raw/hendrikdutoit/dockercomposeexample "GitHub - Issue Counter"
[gh_issues_lnk]: https://github.com/hendrikdutoit/dockercomposeexample/issues "GitHub - Issue Counter"
[gh_language_img]: https://img.shields.io/github/languages/top/hendrikdutoit/dockercomposeexample "GitHub - Top Language"
[gh_language_lnk]: https://github.com/hendrikdutoit/dockercomposeexample "GitHub - Top Language"
[gh_last_commit_img]: https://img.shields.io/github/last-commit/hendrikdutoit/dockercomposeexample/master "GitHub - Last Commit"
[gh_last_commit_lnk]: https://github.com/hendrikdutoit/dockercomposeexample/commit/master "GitHub - Last Commit"
[pypi_downloads_img]: https://img.shields.io/pypi/dm/dockercomposeexample "Monthly downloads"
[pypi_downloads_lnk]: https://pypi.org/project/dockercomposeexample/ "Monthly downloads"
[pypi_format_img]: https://img.shields.io/pypi/wheel/dockercomposeexample "PyPI - Format"
[pypi_format_lnk]: https://pypi.org/project/dockercomposeexample/ "PyPI - Format"
[pypi_py_versions_img]: https://img.shields.io/pypi/pyversions/dockercomposeexample "PyPI - Supported Python Versions"
[pypi_py_versions_lnk]: https://pypi.org/project/dockercomposeexample/ "PyPI - Supported Python Versions"
[pypi_release_img]: https://img.shields.io/pypi/v/dockercomposeexample "Test status"
[pypi_release_lnk]: https://pypi.org/project/dockercomposeexample/ "Test status"
