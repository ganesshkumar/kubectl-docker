FROM alpine:3.6

ENV KUBE_VERSION={{VERSION}}

LABEL org.label-schema.vcs-url="https://github.com/ganesshkumar/kubectl-docker" \
      org.label-schema.vendor=ganesshkumar.com \
      org.label-schema.name=kubectl \
      org.label-schema.description="Alpine based docker image for kubectl"  \
      com.ganesshkumar.license="Apache License 2.0"

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add --update gettext \
    && curl -L  https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del --purge deps \
    && rm /var/cache/apk/*
