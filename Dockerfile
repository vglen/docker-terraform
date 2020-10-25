FROM alpine:3.12.1
LABEL Glen Stummer <glen@glen.dev>

ENV TERRAFORM_VERSION=0.13.5
ENV TERRAFORM_SHA256SUM=f7b7a7b1bfbf5d78151cfe3d1d463140b5fd6a354e71a7de2b5644e652ca5147

RUN apk add --no-cache \
    git~=2.26.2 &&\
    apk add --no-cache --virtual .build-deps \
    zip~=3.0 \
    wget~=1.20.3-r1 \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -c terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /bin/terraform && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    apk del --purge .build-deps

ENTRYPOINT [ "/bin/terraform" ]

CMD ["terraform"]