FROM golang as builder
MAINTAINER Celes Hillyerd

ENV DEBIAN_FRONTEND noninteractive
RUN apt update
RUN apt -y install git 

# Build Retro Aim

WORKDIR /tmp
RUN git clone https://github.com/mk6i/retro-aim-server
WORKDIR /tmp/retro-aim-server
RUN go install github.com/vektra/mockery/v2@latest
RUN go build -o retro_aim_server ./cmd/server
RUN mockery
RUN go test -race ./...

FROM ubuntu:24.04
ENV TZ=America/Los_Angeles
ENV DEBIAN_FRONTEND noninteractive
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
RUN apt update
RUN apt -y full-upgrade && apt-get install -y \
  curl \
  less \
  openssh-server \
  software-properties-common \
  sudo \
  vim \
  zstd \
  $ADDITIONAL_PACKAGES 

COPY --from=builder /tmp/retro-aim-server/retro_aim_server /usr/bin/retro_aim_server
RUN mkdir -p /usr/share/retro_aim_server
COPY --from=builder /tmp/retro-aim-server/config/settings.env /usr/share/retro_aim_server/settings.env
ADD bin /usr/bin

# Docker config
VOLUME ["/etc/ssh","/app/data"]
EXPOSE 8080 5190 5191 5192 5193 5193 5194 5195 5196 5197
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
CMD ["supervisord"]

