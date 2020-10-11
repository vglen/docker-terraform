FROM alpine:3.12.0
LABEL Glen Stummer <glen@glen.dev>

ENV TERRAFORM_VERSION=0.13.4
ENV TERRAFORM_SHA256SUM=de6e178a211f009615b3896e619aafd5c3164a8ce13cb6ff67bc951d87e90bbb

RUN apk add --no-cache \
    ruby-full~=2.7.1 \
    jq~=1.6 \
    tree~=1.8.0 \
    git~=2.26.2 &&\
    apk add --no-cache --virtual .build-deps \
    zip~=3.0 \
    wget~=1.20.3-r1 \
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