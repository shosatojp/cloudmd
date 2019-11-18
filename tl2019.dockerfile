FROM ubuntu:18.04
ARG port=8083
# install packages
RUN apt-get update && apt-get install -y \
    pandoc \
    sudo \
    wget \
    curl \
    git \
    python3.8 \
    python3-pip
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
    sudo apt-get install -y nodejs
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar xf install-tl-unx.tar.gz && cd install-tl-20191117 && \
    echo 'selected_scheme scheme-full' >> profile && \
    echo 'binary_x86_64-linux 1' >> profile && \
    ./install-tl --profile profile


# system settings
RUN adduser --disabled-password --gecos "" cloudmd