# Repository with Dockerfiles and Scripts for DeepKS 
## The Build for DeepKS is broken into three sub-builds:

| Build Order | Dockerfile | Description | Required Image Name |
|-------------|------------|-------------|---------------------|
|      1      |`r.dockerfile`| Downloads R and the R packages required for DeepKS. | `deepks-r`|
|      2      |`deepks-core-depends.dockerfile`| Downloads and installs the basic `apt-get` packages, the DeepKS repository, python, etc., required for DeepKS.| `deepks-core-depends`|
|      3      |`final-steps.dockerfile`| Downloads VS Code, any additional pip or apt packages needed since building core dependences, and creates a "graceful presentation"/welcome message in the shell for the end-user. | `deepks` |

## To re-build the final image 
In the following order, execute:

```bash
R_BLD_VERSION_NUM='X.Y.Z'

CORE_BLD_VERSION_NUM='X.Y.Z'

FINAL_BLD_VERSION_NUM='X.Y.Z'

docker buildx create --use

docker buildx build --platform linux/arm64,linux/amd64 -f r.dockerfile -t benndrucker/deepks-r:latest -t benndrucker/deepks-r:$R_BLD_VERSION_NUM --push . 

docker buildx build --platform linux/arm64,linux/amd64 -f deepks-core-depends.dockerfile -t benndrucker/deepks-core-depends:latest -t benndrucker/deepks-core-depends-r:$CORE_BLD_VERSION_NUM --push . 

docker buildx build --platform linux/arm64,linux/amd64 -f final-steps.dockerfile -t benndrucker/deepks:latest -t benndrucker/deepks:$FINAL_BLD_VERSION_NUM --push . 

```
making sure to replace the `X.Y.Z` in the first three lines with the version number (e.g., `0.2.0`).

Each of these builds may be lengthy since they are multi-platform builds; I.e., the builds are created for both ARM and x86_64 platforms. Hence, if making changes to the dockerfiles or associated scripts, one may want to build only for their computer's native architecture. To do this, execute:

```bash
docker build -f r.dockerfile -t benndrucker/deepks-r:latest . # Example for the `r.dockerfile` build
```

making sure to replace the dockerfile name and tag name appropriately. 