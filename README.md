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
