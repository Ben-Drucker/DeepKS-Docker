
FROM ubuntu:23.04
COPY install_script.sh /home/ubuntu/install_script.sh

RUN apt-get update && apt-get install -y \
    wget \
    gpg \
    sudo \
    x11-apps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN bash /home/ubuntu/install_script.sh

CMD /usr/share/code/bin/code-tunnel tunnel --accept-server-license-terms
