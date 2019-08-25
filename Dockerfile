FROM ubuntu:18.04
MAINTAINER Glen Stummer <glen@glen.dev>

ENV TERRAFORM_VERSION=0.12.7
ENV TERRAFORM_SHA256SUM=a0fa11217325f76bf1b4f53b0f7a6efb1be1826826ef8024f2f45e60187925e7

RUN mkdir -p ~/.ssh && echo "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config

COPY files/terminal-to-html /usr/local/bin/

RUN apt-get update && apt-get -y dist-upgrade && apt-get autoremove && apt-get install -y ruby-full zip curl wget jq tree git && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -c terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /bin/terraform && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN gem install terraform_landscape

CMD ["/bin/bash"]