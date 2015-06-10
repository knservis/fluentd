FROM ubuntu:14.04
MAINTAINER Konstantinos Servis <knservis@gmail.com>

# install curl and fluentd deps
RUN apt-get update \
    && apt-get install -y curl libcurl4-openssl-dev ruby ruby-dev make

# install fluentd with plugins
RUN gem install fluentd --no-ri --no-rdoc \
    && fluent-gem install fluent-plugin-cloudwatch-logs \
    fluent-plugin-record-modifier \
    && mkdir /etc/fluentd/

# install docker-gen
RUN cd /usr/local/bin \
    && curl -L https://github.com/jwilder/docker-gen/releases/download/0.4.0/docker-gen-linux-amd64-0.4.0.tar.gz \
    | tar -xzv

# add startup scripts and config files
ADD ./bin    /app/bin
ADD ./config /app/config

WORKDIR /app

ENV DOCKER_HOST unix:///tmp/docker.sock

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/app/bin/start" ]
