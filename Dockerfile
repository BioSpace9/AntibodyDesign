FROM nvidia/cuda:11.6.0-devel-ubuntu18.04

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    curl \
    git \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    make \
    unzip \
    vim \
    wget \
    xz-utils \
    zlib1g-dev

ENV PYTHON_VERSION 3.7.9
ENV HOME /root
ENV PYTHON_ROOT $HOME/local/python-$PYTHON_VERSION
ENV PATH $PYTHON_ROOT/bin:$PATH
ENV PYENV_ROOT $HOME/.pyenv

RUN git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT \
    && $PYENV_ROOT/plugins/python-build/install.sh \
    && /usr/local/bin/python-build -v $PYTHON_VERSION $PYTHON_ROOT \
    && rm -rf $PYENV_ROOT

RUN pip install --upgrade pip \
    && pip install \
    numpy \
    pandas \
    matplotlib \
    torch \
    torchvision \
    torchaudio \
    jupyterlab \
    torchinfo \
    mmtf-python \
    tqdm
 
WORKDIR /work
RUN git clone https://github.com/wengong-jin/RefineGNN.git \
    && cd /work/RefineGNN \
    && gunzip -r ./data \
    && cd /work/RefineGNN \
    && git clone https://github.com/BisSpace9/AntibodyDesign/blob/main/rabd_test_10seqs.py