FROM docker:18.09-dind AS docker

FROM clojure:lein-alpine AS clojure

# FROM openjdk:8-jdk-slim AS eta
#
# RUN apt-get -q update && \
#     apt-get -q install -y --no-install-recommends ca-certificates netbase curl git gcc g++ zlib1g-dev libncurses5-dev libbz2-dev && \
#     curl -sSL https://get.haskellstack.org/ | sh && \
#     mkdir -p $HOME/.local/bin && \
#     rm -rf /tmp/* \
#            /var/cache/apk/* && \
#     apt-get autoclean && \
#     apt-get clean && \
#     apt-get autoremove && \
#     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#
# RUN mkdir -p /usr/local/bin \
#     && git clone --recursive https://github.com/typelead/eta \
#     && cd eta \
#     && stack install etlas --ghc-options='-optl-static -optl-pthread -fPIC' --local-bin-path="/usr/local/bin"

FROM golang:1.11-alpine AS go

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
    git \
    curl \
    gcc \
    musl-dev \
    wget

RUN go get -v -u \
    github.com/alecthomas/gometalinter \
    github.com/davidrjenni/reftools/cmd/fillstruct \
    github.com/derekparker/delve/cmd/dlv \
    github.com/fatih/gomodifytags \
    github.com/fatih/motion \
    github.com/josharian/impl \
    github.com/jstemmer/gotags \
    github.com/kisielk/errcheck \
    github.com/klauspost/asmfmt/cmd/asmfmt \
    github.com/koron/iferr \
    github.com/mdempsky/gocode \
    github.com/rogpeppe/godef \
    github.com/stamblerre/gocode \
    github.com/zmb3/gogetdoc \
    golang.org/x/lint/golint \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/tools/cmd/golsp \
    golang.org/x/tools/cmd/gorename \
    golang.org/x/tools/cmd/guru \
    honnef.co/go/tools/cmd/keyify \
    && gometalinter -i

FROM alpine:latest AS base

LABEL maintainer "Rintaro Okamura <rintaro.okamura@gmail.com>"

RUN apk update \
    && apk upgrade \
    && apk --update add --no-cache \
    bash \
    cmake \
    ctags \
    curl \
    diffutils \
    g++ \
    gawk \
    gcc \
    git \
    gnupg \
    jq \
    less \
    linux-headers \
    make \
    musl-dev \
    ncurses \
    neovim \
    nodejs \
    npm \
    openjdk8 \
    openssh \
    openssl \
    openssl-dev \
    perl \
    py-pip \
    py3-pip \
    python-dev \
    python3-dev \
    tar \
    tmux \
    tzdata \
    wget \
    zsh \
    && rm -rf /var/cache/apk/*

RUN pip2 install --upgrade pip neovim \
    && pip3 install --upgrade pip neovim \
    && npm config set user root \
    && npm install -g neovim

ENV LANG en_US.UTF-8

ENV TZ Asia/Tokyo
ENV HOME /root
ENV GOPATH $HOME/local
ENV GOROOT /usr/local/go
ENV DOTFILES $HOME/.dotfiles
ENV SHELL /bin/zsh

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/bin

RUN mkdir -p $HOME/.ssh \
    && ssh-keyscan github.com >> $HOME/.ssh/known_hosts

COPY --from=docker /usr/local/bin/containerd /usr/bin/docker-containerd
COPY --from=docker /usr/local/bin/containerd-shim /usr/bin/docker-containerd-shim
COPY --from=docker /usr/local/bin/ctr /usr/bin/docker-containerd-ctr
COPY --from=docker /usr/local/bin/dind /usr/bin/dind
COPY --from=docker /usr/local/bin/docker /usr/bin/docker
COPY --from=docker /usr/local/bin/docker-entrypoint.sh /usr/bin/docker-entrypoint
COPY --from=docker /usr/local/bin/docker-init /usr/bin/docker-init
COPY --from=docker /usr/local/bin/docker-proxy /usr/bin/docker-proxy
COPY --from=docker /usr/local/bin/dockerd /usr/bin/dockerd
COPY --from=docker /usr/local/bin/modprobe /usr/bin/modprobe
COPY --from=docker /usr/local/bin/runc /usr/bin/docker-runc

COPY --from=clojure /usr/local/bin/lein /usr/local/bin/lein
COPY --from=clojure /usr/share/java /usr/share/java

# COPY --from=eta /usr/local/bin/etlas /usr/local/bin/etlas

COPY --from=go /usr/local/go/bin $GOROOT/bin
COPY --from=go /usr/local/go/src $GOROOT/src
COPY --from=go /usr/local/go/lib $GOROOT/lib
COPY --from=go /usr/local/go/pkg $GOROOT/pkg
COPY --from=go /usr/local/go/misc $GOROOT/misc
COPY --from=go /go/bin $GOPATH/bin

RUN mkdir $DOTFILES
WORKDIR $DOTFILES

COPY . .

RUN ["/bin/bash", "-c", "make -j4 deploy && make prepare-init && make neovim-init && make tmux-init"]

RUN echo -e '[user]\n\
    name = Rintaro Okamura\n\
    email = rintaro.okamura@gmail.com\n\
' >$HOME/.gitconfig.local

WORKDIR $HOME

CMD ["zsh"]

