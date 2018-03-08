# Alpine-LDC

A compilation for D code using LDC running on Alpine Linux.  Perfect for multi-stage docker builds or playing with light environments.  Dub is also included in this container.

## Building

This is a pretty regular docker build.  The appropriate [LDC][ldc] version and the latest version of [Dub][dub] that the [dub-registry](https://code.dlang.org) knows about will be pulled down during the container build process.

Optionally, a build argument can be supplied to set the version of [LDC][ldc] to pull.  The default is `v1.8.0`.

Example:
``` bash
export LDC_VERSION=1.8.0
docker build --build-arg "LDC_VERSION=${LDC_VERSION}" -t "alpine-ldc:${LDC_VERSION}" .

# or

make LDC=1.8.0
```

## Running

Once the docker container is built or pulled, running it is easy.

``` plain
$ docker run -it --rm alpine-ldc:1.8.0
/ # cd /tmp
/tmp # echo 'void main() { import std.stdio; writeln("hello, world!"); } ' > test.d
/tmp # ldc2 test.d -of test
/tmp # /tmp/test
hello, world!
/tmp # exit
```

## Example

Examples require that you have [docker][docker_install] installed on your machine.  [This][simple_example] is the simplest example.

## Known issues

- For whatever reason, the interactive `dub init` prompt doesn't quite work.  
- The libc version used is musl, which isn't as well supported in druntime as glibc.

[ldc]: https://github.com/ldc-developers/ldc
[dub]: https://github.com/dlang/dub
[docker_install]: https://docs.docker.com/install
[simple_example]: ./example/rpn-calculator
