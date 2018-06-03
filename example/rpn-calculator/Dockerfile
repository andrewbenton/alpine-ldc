FROM andrewbenton/alpine-ldc:v1.9.0 as packager

COPY . /src

RUN \
    cd /src && \
    dub build --build release

FROM alpine:3.7

COPY --from=packager /src/rpn-calculator /

ENTRYPOINT [ "/rpn-calculator" ]
