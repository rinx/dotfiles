## --- [{:name "GRAALVM_VERSION"
## ---   :tx "(fn [x] (string/replace x #\"vm-\" \"\"))"
## ---   :url "https://api.github.com/repos/graalvm/graalvm-ce-builds/tags"}
## ---  {:name "CLOJURE_LSP_VERSION"
## ---   :url "https://api.github.com/repos/clojure-lsp/clojure-lsp/releases"}
## ---  {:name "KOTLIN_LS_VERSION"
## ---   :url "https://api.github.com/repos/fwcd/kotlin-language-server/tags"}]

ARG GRAALVM_VERSION=21.1.0
ARG GRAALVM_JAVA_VERSION=java11

ARG FENNEL_VERSION=0.9.1

ARG CLOJURE_LSP_VERSION=2021.04.23-15.49.47
ARG KOTLIN_LS_VERSION=1.1.1

FROM docker:dind AS docker

RUN mkdir -p /out

RUN cp /usr/local/bin/containerd      /out
RUN cp /usr/local/bin/containerd-shim /out
RUN cp /usr/local/bin/ctr             /out
RUN cp /usr/local/bin/docker          /out
RUN cp /usr/local/bin/docker-init     /out
RUN cp /usr/local/bin/docker-proxy    /out
RUN cp /usr/local/bin/dockerd         /out
RUN cp /usr/local/bin/runc            /out

FROM clojure:lein-alpine AS clojure-lein

FROM clojure:tools-deps-alpine AS clojure-deps

FROM rust:slim AS rust

FROM golang:alpine AS go

RUN apk update \
    && apk upgrade \
    && apk --update-cache add --no-cache \
    git \
    curl \
    gcc \
    musl-dev \
    wget

RUN go install golang.org/x/tools/cmd/goimports@latest \
    && GO111MODULE=on go get golang.org/x/tools/gopls@latest

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

FROM ubuntu:groovy AS neovim

RUN apt update \
    && apt install -y \
    autoconf \
    automake \
    cmake \
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
    && git clone --depth 1 https://github.com/neovim/neovim \
    && cd /tmp/neovim \
    && make CMAKE_BUILD_TYPE=RelWithDebInfo \
    && make install \
    && upx -9 /usr/local/bin/nvim

FROM alpine:latest AS packer

RUN apk update \
    && apk upgrade \
    && apk --update-cache add --no-cache \
    upx

COPY --from=docker /out /out/docker
RUN upx -9 /out/docker/*

COPY --from=go /out /out/go
RUN upx -9 /out/go/usr/local/go/bin/*
RUN upx -9 /out/go/go/bin/*

COPY --from=kube /out/packer /out/kube
RUN upx -9 /out/kube/*

FROM ubuntu:groovy AS base

LABEL maintainer "Rintaro Okamura <rintaro.okamura@gmail.com>"
ARG GRAALVM_VERSION
ARG GRAALVM_JAVA_VERSION
ARG FENNEL_VERSION
ARG CLOJURE_LSP_VERSION
ARG KOTLIN_LS_VERSION

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TZ Asia/Tokyo
ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
    && apt install -y \
    autoconf \
    automake \
    bison \
    cmake \
    curl \
    diffutils \
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
    yarn \
    zip \
    zsh \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip neovim \
    && npm config set user root \
    && npm install -g neovim

RUN npm install -g \
    bash-language-server \
    dockerfile-language-server-nodejs \
    typescript \
    typescript-language-server \
    vscode-json-languageserver \
    yaml-language-server \
    && pip3 install \
    fortran-language-server \
    hy

ENV GRAALVM_HOME /usr/lib/graalvm
RUN cd /tmp \
    && curl -sL "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_JAVA_VERSION}-linux-amd64-${GRAALVM_VERSION}.tar.gz" --output graalvm.tar.gz \
    && mkdir -p ${GRAALVM_HOME} \
    && tar -xf graalvm.tar.gz -C ${GRAALVM_HOME} --strip-components=1 \
    && chmod -R a+rwx ${GRAALVM_HOME} \
    && rm -rf graalvm.tar.gz \
    && upx -9 $(find /usr/lib/graalvm -name js -type f -executable | head -1) \
    && upx -9 $(find /usr/lib/graalvm -name lli -type f -executable | head -1)

RUN curl "https://fennel-lang.org/downloads/fennel-${FENNEL_VERSION}" -o /usr/local/bin/fennel \
    && chmod a+x /usr/local/bin/fennel

RUN cd /tmp \
    && curl -OL "https://github.com/clojure-lsp/clojure-lsp/releases/download/${CLOJURE_LSP_VERSION}/clojure-lsp-native-linux-amd64.zip" \
    && unzip clojure-lsp-native-linux-amd64.zip \
    && mv clojure-lsp /usr/local/bin/ \
    && rm -rf clojure-lsp-native-linux-amd64.zip

RUN cd /tmp \
    && curl -L "https://github.com/fwcd/kotlin-language-server/releases/download/${KOTLIN_LS_VERSION}/server.zip" --output kotlin-ls.zip \
    && unzip kotlin-ls.zip \
    && rm -f kotiln-ls.zip \
    && mv server /usr/local/kotlin-language-server \
    && ln -sf /usr/local/kotlin-language-server/bin/kotlin-language-server /usr/local/bin/kotlin-language-server

RUN cd /tmp \
    && curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o /usr/local/bin/rust-analyzer \
    && chmod a+x /usr/local/bin/rust-analyzer \
    && upx -9 /usr/local/bin/rust-analyzer

RUN curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash \
    && upx -9 /usr/local/bin/k3d

ENV HOME /root
ENV DOTFILES $HOME/.dotfiles

ENV SHELL /bin/zsh
ENV EDITOR nvim

ENV GOPATH $HOME/local
ENV GOROOT /usr/local/go
ENV JAVA_HOME ${GRAALVM_HOME}
ENV RUSTUP_HOME /usr/local/rustup
ENV CARGO_HOME /usr/local/cargo

ENV PATH $PATH:$JAVA_HOME/bin:$GOPATH/bin:$GOROOT/bin:$CARGO_HOME/bin:/usr/local/bin:$HOME/.config/nvim/plugged/vim-iced/bin

ENV GO111MODULE auto
ENV DOCKER_BUILDKIT 1
ENV DOCKER_CLI_EXPERIMENTAL "enabled"
ENV DOCKERIZED_DEVENV rinx/devenv

RUN mkdir -p $HOME/.ssh \
    && ssh-keyscan github.com >> $HOME/.ssh/known_hosts

COPY --from=docker /usr/local/bin/docker-entrypoint.sh /usr/bin/docker-entrypoint
COPY --from=docker /usr/local/bin/dind                 /usr/bin/dind
COPY --from=docker /usr/local/bin/modprobe             /usr/bin/modprobe

COPY --from=packer /out/docker/containerd      /usr/bin/docker-containerd
COPY --from=packer /out/docker/containerd-shim /usr/bin/docker-containerd-shim
COPY --from=packer /out/docker/ctr             /usr/bin/docker-containerd-ctr
COPY --from=packer /out/docker/docker          /usr/bin/docker
COPY --from=packer /out/docker/docker-init     /usr/bin/docker-init
COPY --from=packer /out/docker/docker-proxy    /usr/bin/docker-proxy
COPY --from=packer /out/docker/dockerd         /usr/bin/dockerd
COPY --from=packer /out/docker/runc            /usr/bin/docker-runc

COPY --from=clojure-lein /usr/local/bin/lein /usr/local/bin/lein
COPY --from=clojure-lein /usr/share/java     /usr/share/java

COPY --from=clojure-deps /usr/local/bin/clojure /usr/local/bin/clojure
COPY --from=clojure-deps /usr/local/bin/clj     /usr/local/bin/clj
COPY --from=clojure-deps /usr/local/lib/clojure /usr/local/lib/clojure

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

COPY deps.edn             $DOTFILES/deps.edn
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

RUN mkdir -p $HOME/.docker
COPY docker-config.json $HOME/.docker/config.json

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && locale-gen --purge $LANG

RUN ["/bin/bash", "-c", "make -j4 deploy"]
RUN ["/bin/zsh", "-c", "make prepare-init && make neovim-init && make tmux-init"]

# RUN ["/bin/zsh", "-c", "source ~/.zshrc && zinit self-update && zinit update --all"]

RUN rm -rf /tmp/*

WORKDIR $HOME

ENTRYPOINT ["docker-entrypoint"]
CMD ["zsh"]
