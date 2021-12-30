# `libcxx` and `libcxx-abi` LLVM-IR generation

This repo is used to create LLVM IR representations of
`libcxx` and `libcxx-abi`.

Depends on:
- LLVM
- clang
- [gllvm](https://github.com/SRI-CSL/gllvm)
- Make, cmake, Ninja (the humour is not lost on me here)

To get the LLVM IR just run `make` in the root directory
and find all the files in `ll/`

## Alpine Docker build

Currently, the build is set up to work on an Alpine Docker container.
To make the Docker image:
```bash
docker build - < Dockerfile
sudo docker tag "<tag from prev cmd>" insufficientlycaffeinated/alpine-bob:latest
docker run -v "<path to repo>":/build -it insufficientlycaffeinated/alpine-bob:latest /bin/sh
(docker shell) cd build
(docker shell) make clean
(docker shell) make
```

To deploy the Docker container to the Docker registry:
```bash
docker push insufficientlycaffeinated/alpine-bob:latest
```
