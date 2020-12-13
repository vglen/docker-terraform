FROM alpine:3.12.2
LABEL Glen Stummer <glen@glen.dev>

ENV TERRAFORM_VERSION=0.14.2
ENV TERRAFORM_SHA256SUM=6f380c0c7a846f9e0aedb98a2073d2cbd7d1e2dc0e070273f9325f1b69e668b2

RUN apk add --no-cache \
    git~=2.26.2 &&\
    apk add --no-cache --virtual .build-deps \
    zip~=3.0 \
    curl~=7.69.1 &&\
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -c terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /bin/terraform && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    apk del --purge .build-deps

ENTRYPOINT [ "/bin/terraform" ]

CMD ["terraform"]