FROM gcr.io/cloud-builders/gcloud

ARG HELM_VERSION=v3.1.2
ARG SKAFFOLD_VERSION=v1.6.0

COPY skaffold.sh /builder/
COPY bootstrap.sh /builder/

RUN chmod +x /builder/*.sh && \
    mkdir -p /builder/bin && \
    apt-get update && \
    apt-get install -y curl sudo && \
    curl -SL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
    tar zxvf helm.tar.gz --strip-components=1 -C /builder/bin linux-amd64 && \
    rm helm.tar.gz && \
    curl -sSLo /builder/bin/skaffold https://storage.googleapis.com/skaffold/releases/${SKAFFOLD_VERSION}/skaffold-linux-amd64 && \
    chmod +x /builder/bin/skaffold && \
    apt-get --purge -y autoremove && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/builder/bin/:$PATH
ENV DOCKER_CONFIG=/builder/home/.docker

ENTRYPOINT ["/builder/skaffold.sh"]
