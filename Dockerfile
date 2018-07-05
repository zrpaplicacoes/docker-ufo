FROM ruby:2.5.1-alpine3.7

LABEL author="ZRP Aplicacoes Informaticas LTDA <zrp@zrp.com.br>"
LABEL vendor="ZRP Aplicações Informáticas LTDA - ME"
LABEL license="Apache-2.0"

ARG ufo_version=
ENV LOG=file

RUN apk --no-cache update && \
    apk --no-cache add \
      docker \
      bash \
      iptables \
      python \
      py-pip \
      py-setuptools \
      ca-certificates \
      curl \
      groff \
      e2fsprogs \
      less && \
    pip install pip --upgrade && \
    pip --no-cache-dir install awscli docker-compose && \
    apk --no-cache add g++ make && \
    rm -rf /var/cache/apk/*

RUN gem install bundler rubocop bundler-audit brakeman --no-rdoc --no-ri && \
    if [ -z $ufo_version ]; then gem install ufo --no-rdoc --no-ri; else gem install ufo --version $ufo_version --no-rdoc --no-ri; fi

ENV DOCKER_HOST=tcp://docker:2375
CMD bash
