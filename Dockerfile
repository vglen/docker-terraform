FROM alpine:3.12.0
LABEL Glen Stummer <glen@glen.dev>

ENV TERRAFORM_VERSION=0.12.29
ENV TERRAFORM_SHA256SUM=872245d9c6302b24dc0d98a1e010aef1e4ef60865a2d1f60102c8ad03e9d5a1d

WORKDIR /

RUN apk add --no-cache \
    aws-cli~=1.18 \
    git~=2.26.2 \
    make~=4.3 \
    openssh~=8.3_p1 \
    jq~=1.6 \
    ansible-lint~=4.2.0 \
    ansible~=2.9.9 \
    curl~=7.69.1\
    yamllint~=1.23.0 &&\
    apk add --no-cache --virtual .build-deps \
    build-base~=0.5 \
    gcc~=9.3.0 \
    libffi-dev~=3.3 \
    musl-dev~=1.1 \
    openssl-dev~=1.1 &&\
    ln -sf /usr/bin/python3 /usr/bin/python &&\
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    apk del --purge .build-deps &&\
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -c terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/terraform && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

CMD ["/bin/bash"]