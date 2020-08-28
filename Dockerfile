FROM docker:latest

ENV GCLOUD_SDK_VERSION="307"

ENV GCLOUD_SDK_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}.0.0-linux-x86_64.tar.gz" \
    PATH="/opt/google-cloud-sdk/bin:${PATH}"

RUN apk --update --no-cache add \
        bash \
        ca-certificates \
        curl \
        openssl \
        python3 && \
    wget -O - -q "${GCLOUD_SDK_URL}" | tar zxf - -C /opt && \
    ln -s /lib /lib64 && \
    /opt/google-cloud-sdk/install.sh --usage-reporting false --path-update true --additional-components docker-credential-gcr --quiet && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
    rm -rf /tmp/* && rm -rf /opt/google-cloud-sdk/.install/.backup

VOLUME ["/root/.config"]
