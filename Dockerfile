FROM python:3.10-alpine

MAINTAINER frekele <leandro@frekele.org>

RUN apk --no-cache add curl

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
	&& mv kubectl /usr/local/bin \
	&& chmod +x /usr/local/bin/kubectl

ADD run.sh /run.sh
RUN chmod +x /run.sh

RUN adduser -S user
USER user
WORKDIR /home/user

ENV PATH /usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/user/.local/bin

# Install awscli
RUN pip install awscli --upgrade --user
