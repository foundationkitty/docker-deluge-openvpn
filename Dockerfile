FROM linuxserver/deluge

VOLUME /config

ARG DOCKERIZE_ARCH=amd64
ARG DOCKERIZE_VERSION=v0.6.1
ARG DUMBINIT_VERSION=1.2.2

# Required for omitting the tzdata configuration dialog
ENV DEBIAN_FRONTEND=noninteractive

# Update, upgrade and install core software
RUN apt update \
    && apt-get install -y wget git curl jq sudo ufw iputils-ping openvpn bc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY root/ /
ADD scripts /etc/scripts/

ENV OPENVPN_USERNAME=**None** \
    OPENVPN_PASSWORD=**None** \
    OPENVPN_PROVIDER=**None** \
    ENABLE_UFW=false \
    UFW_ALLOW_GW_NET=false \
    UFW_EXTRA_PORTS= \
    UFW_DISABLE_IPTABLES_REJECT=false \
    TRANSMISSION_WEB_UI= \
    PUID= \
    PGID= \
    TRANSMISSION_WEB_HOME= \
    DROP_DEFAULT_ROUTE= \
    WEBPROXY_ENABLED=false \
    WEBPROXY_PORT=8888 \
    WEBPROXY_USERNAME= \
    WEBPROXY_PASSWORD= \
    HEALTH_CHECK_HOST=google.com \
    DOCKER_LOG=false \
    LOG_TO_STDOUT=false
    DROP_DEFAULT_ROUTE=
	
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
      CMD curl -L -f https://api.ipify.org || exit 1
      
# Expose port and run
EXPOSE 9091
EXPOSE 8888
