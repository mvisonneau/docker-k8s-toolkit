FROM alpine:3.7

ENV KUBECTL_VERSION v1.10.1
ENV HELM_VERSION v2.8.2
ENV HELM_PLUGIN_S3_VERSION v0.6.1

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN \
apk --no-cache add git curl make openssl bash gettext jq && \
curl -sSL https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xz && \
mv linux-amd64/helm /usr/local/bin/helm && \
rm -rf linux-amd64 && \
helm init -c && \
helm plugin install https://github.com/hypnoglow/helm-s3.git --version ${HELM_PLUGIN_S3_VERSION} && \
&& mkdir ~/.kube

VOLUME ["~/.kube"]

ENTRYPOINT []
