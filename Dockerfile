FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y xterm openssl inetutils-ping libjpeg8-dev libxml2 libxm4 xvfb vim nano less wget libssl-dev

COPY ./pathway-tools-26.0-linux-64-tier1-install /opt
RUN /opt/pathway-tools-26.0-linux-64-tier1-install --mode unattended --InstallDir /opt/pathway-tools

EXPOSE 5000
ENTRYPOINT [ "/opt/pathway-tools/pathway-tools", "-python" ]
