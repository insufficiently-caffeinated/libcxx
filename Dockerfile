FROM alpine:3.15

COPY --from=golang:1.17-alpine /usr/local/go/ /usr/local/go/

RUN apk update && apk upgrade && \
    apk add --no-cache git make cmake ninja llvm12-dev clang binutils musl-dev gcc clang-dev build-base python3
RUN go install github.com/SRI-CSL/gllvm/...@v1.3.0
ENV PATH="/root/go/bin:/usr/local/go/bin/:${PATH}"
