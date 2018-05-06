FROM alpine:3.7

Label maintainer="Andrew Benton <andrew.benton675@gmail.com>"

ARG LDC_VERSION=1.9.0

RUN \
    apk add --no-cache bash llvm5 musl-dev gcc curl libcurl curl-dev tzdata openssl jq xz git && \
    cd / && curl -fsS -L -o "/ldc.tar.xz" "https://github.com/ldc-developers/ldc/releases/download/v${LDC_VERSION}/ldc2-${LDC_VERSION}-alpine-linux-x86_64.tar.xz" && \
    tar xf /ldc.tar.xz && \
    mv "/ldc2-${LDC_VERSION}-alpine-linux-x86_64" "/ldc" && \
    rm -rf /ldc.tar.xz

ENV \
    PATH="/ldc/bin:${PATH}" \
    LD_LIBRARY_PATH="/ldc/lib:/usr/lib:/lib:${LD_LIBRARY_PATH}" \
    LIBRARY_PATH="/ldc/lib:/usr/lib:/lib:${LD_LIBRARY_PATH}"

RUN \
    git clone https://github.com/dlang/dub /dub && \
    cd /dub && git checkout "v$(curl https://code.dlang.org/api/packages/dub/info 2> /dev/null | jq '.versions[].version' -r | egrep '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -n 1)" && \
    bash ./build.sh && \
    cd /dub/bin && \
    rm *.dll *.o && \
    ln -s /dub/bin/dub /bin/. && \
    apk del bash jq xz && \
    rm -rf /var/cache/apk/*

ENTRYPOINT [ "sh" ]
