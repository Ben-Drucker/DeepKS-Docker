FROM nvidia/cuda:12.0.0-base-ubuntu22.04
COPY install_script.sh /home/ubuntu/install_script.sh
COPY requirements.txt /home/ubuntu/requirements.txt

RUN apt-get update && apt-get install -y \
    wget \
    gpg \
    sudo \
    x11-apps \
    git \
    zsh \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN touch /home/ubuntu/.zshrc

ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

RUN cd /home/ubuntu
RUN conda config --add channels conda-forge && conda config --set channel_priority strict && conda create -n py311 python=3.11 && conda init --verbose --system zsh 

RUN zsh -c 'source /root/.zshrc && conda activate py311 && pip install -r /home/ubuntu/requirements.txt'

CMD /usr/share/code/bin/code-tunnel tunnel --accept-server-license-terms
# CMD /bin/zsh 
