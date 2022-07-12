## --- [{:name "CLOJURE_LSP_VERSION"
## ---   :url "https://api.github.com/repos/clojure-lsp/clojure-lsp/releases"}
## ---  {:name "RUST_ANALYZER_VERSION"
## ---   :url "https://api.github.com/repos/rust-analyzer/rust-analyzer/releases"}
## ---  {:name "BUF_VERSION"
## ---   :url "https://api.github.com/repos/bufbuild/buf/tags"}]

ARG CLOJURE_LSP_VERSION=2022.06.29-19.32.13
ARG RUST_ANALYZER_VERSION=nightly
ARG BUF_VERSION=v1.6.0

FROM rust:slim AS rust

FROM golang:alpine AS go

RUN apk update \
    && apk upgrade \
    && apk --update-cache add --no-cache \
    make \
    git \
    curl \
    gcc \
    musl-dev \
    wget

RUN go install github.com/go-delve/delve/cmd/dlv@latest \
    && go install github.com/mattn/efm-langserver@latest \
    && go install golang.org/x/tools/gopls@latest \
    && go install github.com/x-motemen/ghq@latest

RUN git clone --depth 1 https://github.com/cli/cli.git /tmp/gh-cli \
    && cd /tmp/gh-cli \
    && make \
    && mv bin/gh /usr/local/go/bin

RUN mkdir -p /out/usr/local/go
RUN mkdir -p /out/go
RUN cp -r /usr/local/go/bin /out/usr/local/go/bin
RUN cp -r /go/bin /out/go/bin

FROM alpine:latest AS kube

RUN apk update \
    && apk upgrade \
    && apk --update-cache add --no-cache \
    make \
    curl \
    gcc \
    openssl \
    bash \
    git

RUN mkdir -p /out/packer \
    && mkdir -p /out/kube \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /out/packer/kubectl \
    && chmod a+x /out/packer/kubectl \
    && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash \
    && mv /usr/local/bin/helm /out/packer/helm

FROM ubuntu:rolling AS neovim

RUN apt update \
    && apt install -y \
    autoconf \
    automake \
    cmake \
    curl \
    g++ \
    gettext \
    git \
    libtool \
    libtool-bin \
    ninja-build \
    pkg-config \
    unzip \
    upx \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && git clone https://github.com/neovim/neovim \
    && cd /tmp/neovim \
    && git checkout stable \
    && make CMAKE_BUILD_TYPE=RelWithDebInfo \
    && make install \
    && upx -9 /usr/local/bin/nvim

FROM alpine:latest AS packer

RUN apk update \
    && apk upgrade \
    && apk --update-cache add --no-cache \
    upx

COPY --from=go /out /out/go
RUN upx -9 /out/go/usr/local/go/bin/*
RUN upx -9 /out/go/go/bin/*

COPY --from=kube /out/packer /out/kube
RUN upx -9 /out/kube/*

FROM ubuntu:rolling AS base

LABEL maintainer "Rintaro Okamura <rintaro.okamura@gmail.com>"
ARG CLOJURE_LSP_VERSION
ARG RUST_ANALYZER_VERSION
ARG BUF_VERSION

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TZ Asia/Tokyo

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive \
    apt install -y \
    autoconf \
    automake \
    bison \
    cmake \
    curl \
    diffutils \
    fzy \
    g++ \
    gawk \
    gcc \
    gettext \
    gfortran \
    git \
    gnupg \
    less \
    libevent-dev \
    liblua5.3-dev \
    libtool \
    libtool-bin \
    locales \
    lua5.3 \
    luarocks \
    make \
    musl-dev \
    ninja-build \
    nodejs \
    npm \
    openssh-client \
    openssh-server \
    openssl \
    perl \
    pkg-config \
    python3-dev \
    python3-pip \
    rlwrap \
    sed \
    tar \
    tmux \
    tzdata \
    unzip \
    upx \
    wget \
    zip \
    zsh \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip neovim neovim-remote \
    && npm config set user root \
    && npm install -g neovim

RUN npm install -g \
    bash-language-server \
    dockerfile-language-server-nodejs \
    markdownlint \
    markdownlint-cli \
    textlint \
    textlint-rule-preset-ja-technical-writing \
    @proofdict/textlint-rule-proofdict \
    typescript \
    typescript-language-server \
    vscode-langservers-extracted \
    yaml-language-server \
    yarn \
    && pip3 install \
    fortran-language-server

RUN cd /tmp \
    && curl -OL "https://github.com/clojure-lsp/clojure-lsp/releases/download/${CLOJURE_LSP_VERSION}/clojure-lsp-native-linux-amd64.zip" \
    && unzip clojure-lsp-native-linux-amd64.zip \
    && mv clojure-lsp /usr/local/bin/ \
    && rm -rf clojure-lsp-native-linux-amd64.zip

RUN cd /tmp \
    && curl -L https://github.com/rust-analyzer/rust-analyzer/releases/download/${RUST_ANALYZER_VERSION}/rust-analyzer-x86_64-unknown-linux-gnu.gz --output rust-analyzer.gz \
    && gunzip rust-analyzer.gz \
    && mv rust-analyzer /usr/local/bin/rust-analyzer \
    && chmod a+x /usr/local/bin/rust-analyzer \
    && upx -9 /usr/local/bin/rust-analyzer

RUN cd /tmp \
    && curl -L https://github.com/bufbuild/buf/releases/download/${BUF_VERSION}/buf-Linux-x86_64 --output buf \
    && mv buf /usr/local/bin/buf \
    && chmod a+x /usr/local/bin/buf \
    && upx -9 /usr/local/bin/buf

ENV HOME /root
ENV DOTFILES $HOME/.dotfiles

ENV SHELL /bin/zsh
ENV EDITOR nvim

ENV GOPATH $HOME/local
ENV GOROOT /usr/local/go
ENV RUSTUP_HOME /usr/local/rustup
ENV CARGO_HOME /usr/local/cargo

ENV PATH $PATH:/usr/local/bin:$CARGO_HOME/bin:$GOROOT/bin:$GOPATH/bin:$DOTFILES/bin:$HOME/.bin

ENV GO111MODULE auto
ENV DOCKERIZED_DEVENV rinx/devenv

RUN mkdir -p $HOME/.ssh \
    && ssh-keyscan github.com >> $HOME/.ssh/known_hosts

COPY --from=rust /usr/local/cargo  $CARGO_HOME
COPY --from=rust /usr/local/rustup $RUSTUP_HOME

COPY --from=go /usr/local/go/src  $GOROOT/src
COPY --from=go /usr/local/go/lib  $GOROOT/lib
COPY --from=go /usr/local/go/pkg  $GOROOT/pkg
COPY --from=go /usr/local/go/misc $GOROOT/misc

COPY --from=packer /out/go/usr/local/go/bin $GOROOT/bin
COPY --from=packer /out/go/go/bin           $GOROOT/bin

COPY --from=packer /out/kube/kubectl   /usr/local/bin/kubectl
COPY --from=packer /out/kube/helm      /usr/local/bin/helm

COPY --from=neovim /usr/local/bin/nvim     /usr/local/bin/nvim
COPY --from=neovim /usr/local/share/locale /usr/local/share/locale
COPY --from=neovim /usr/local/share/nvim   /usr/local/share/nvim

RUN mkdir $DOTFILES
WORKDIR $DOTFILES

COPY gitattributes_global $DOTFILES/gitattributes_global
COPY gitconfig            $DOTFILES/gitconfig
COPY gitignore            $DOTFILES/gitignore
COPY nvim                 $DOTFILES/nvim
COPY Makefile             $DOTFILES/Makefile
COPY Makefile.d           $DOTFILES/Makefile.d
COPY profiles.clj         $DOTFILES/profiles.clj
COPY resources            $DOTFILES/resources
COPY tmux.conf            $DOTFILES/tmux.conf
COPY zshrc                $DOTFILES/zshrc
COPY zshrc.d              $DOTFILES/zshrc.d
COPY p10k.zsh             $DOTFILES/p10k.zsh

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && locale-gen --purge $LANG

RUN ["/bin/bash", "-c", "make -j4 deploy"]
RUN ["/bin/bash", "-c", "make -j4 install"]
RUN ["/bin/bash", "-c", "make prepare-init && make tmux-init && make neovim-init"]

RUN rm -rf /tmp/*

WORKDIR $HOME

ENTRYPOINT ["nvim"]
CMD ["--headless", "--listen", "0.0.0.0:16666"]
