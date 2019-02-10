FROM docker:18.09-dind AS docker

FROM clojure:lein-alpine AS clojure

FROM typelead/eta:latest AS eta

FROM ekidd/rust-musl-builder:stable AS rust

RUN cargo install bat \
    exa \
    ripgrep \
    && cargo install --git https://github.com/sharkdp/fd

FROM golang:1.11-stretch AS go

RUN apt-get update \
    && apt-get install -y \
    git \
    curl \
    wget

RUN go get -v -u \
    github.com/alecthomas/gometalinter \
    github.com/davidrjenni/reftools/cmd/fillstruct \
    github.com/derekparker/delve/cmd/dlv \
    github.com/fatih/gomodifytags \
    github.com/fatih/motion \
    github.com/josharian/impl \
    github.com/jstemmer/gotags \
    github.com/junegunn/fzf \
    github.com/kisielk/errcheck \
    github.com/klauspost/asmfmt/cmd/asmfmt \
    github.com/koron/iferr \
    github.com/mdempsky/gocode \
    github.com/motemen/ghq \
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

FROM ubuntu:devel AS base

LABEL maintainer "Rintaro Okamura <rintaro.okamura@gmail.com>"

RUN apt-get update \
    && apt-get install -y \
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
    locales \
    make \
    neovim \
    nodejs \
    npm \
    openjdk-12-jdk \
    openssh-client \
    openssh-server \
    openssl \
    perl \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    tar \
    tmux \
    wget \
    zsh \
    && rm -rf /var/lib/apt/lists/*

RUN pip2 install --upgrade pip neovim \
    && pip3 install --upgrade pip neovim \
    && npm config set user root \
    && npm install -g neovim

RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8
ENV LANG ja_JP.UTF-8

ENV TZ Asia/Tokyo
ENV HOME /root
ENV GOPATH $HOME/local
ENV GOROOT /usr/local/go
ENV DOTFILES $HOME/.dotfiles
ENV SHELL /bin/zsh

ENV JAVA_HOME /usr/lib/jvm/java-12-openjdk-amd64

ENV PATH $PATH:$JAVA_HOME/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/bin

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
RUN echo '(defproject dummy "" :dependencies [[org.clojure/clojure "1.10.0"]])' > project.clj \
    && lein deps \
    && rm project.clj

COPY --from=eta /root/.local/bin/etlas /usr/local/bin/etlas

COPY --from=rust /home/rust/.cargo/bin/bat /usr/local/bin/bat
COPY --from=rust /home/rust/.cargo/bin/exa /usr/local/bin/exa
COPY --from=rust /home/rust/.cargo/bin/fd /usr/local/bin/fd
COPY --from=rust /home/rust/.cargo/bin/rg /usr/local/bin/rg

COPY --from=go /usr/local/go/bin $GOROOT/bin
COPY --from=go /usr/local/go/src $GOROOT/src
COPY --from=go /usr/local/go/lib $GOROOT/lib
COPY --from=go /usr/local/go/pkg $GOROOT/pkg
COPY --from=go /usr/local/go/misc $GOROOT/misc
COPY --from=go /go/bin $GOPATH/bin

RUN mkdir $DOTFILES
WORKDIR $DOTFILES

COPY . .

RUN ["/bin/bash", "-c", "make -j4 deploy"]
RUN ["/bin/bash", "-c", "make prepare-init && make neovim-init && make tmux-init"]

RUN echo '[user]\n\
    name = Rintaro Okamura\n\
    email = rintaro.okamura@gmail.com\n\
' >$HOME/.gitconfig.local

WORKDIR $HOME

CMD ["zsh"]

