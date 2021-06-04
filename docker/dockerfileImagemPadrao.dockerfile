FROM docker-unj-repo.softplan.com.br/unj-integracoes/ubuntu-delphi-mongo:1.1.0

RUN apt-get update
RUN apt-get install -y curl
RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/log
VOLUME ["/usr/src/app/log"]

WORKDIR /usr/src/app

ADD app/ /usr/src/app

