FROM docker:dind AS docker

FROM clojure:lein-alpine AS clojure-lein

FROM clojure:tools-deps-alpine AS clojure-deps

FROM ekidd/rust-musl-builder:stable AS rust

RUN cargo install bat \
    exa \
    ripgrep \
    && cargo install --git https://github.com/sharkdp/fd

FROM golang:alpine AS go

RUN apk update \
    && apk upgrade \
    && apk --update add --no-cache \
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
    github.com/junegunn/fzf \
    github.com/kisielk/errcheck \
    github.com/klauspost/asmfmt/cmd/asmfmt \
    github.com/koron/iferr \
    github.com/mdempsky/gocode \
    github.com/motemen/ghq \
    github.com/rogpeppe/godef \
    github.com/saibing/bingo \
    github.com/stamblerre/gocode \
    github.com/zmb3/gogetdoc \
    golang.org/x/lint/golint \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/tools/cmd/gorename \
    golang.org/x/tools/cmd/guru \
    honnef.co/go/tools/cmd/keyify \
    && gometalinter -i

FROM alpine:edge AS base

LABEL maintainer "Rintaro Okamura <rintaro.okamura@gmail.com>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
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
    nss \
    openjdk8 \
    openssh \
    openssl \
    openssl-dev \
    perl \
    py-pip \
    py3-pip \
    python-dev \
    python3-dev \
    # rlwrap \
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

ENV PATH $PATH:$JAVA_HOME/jre/bin:$JAVA_HOME/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/bin

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

COPY --from=clojure-lein /usr/local/bin/lein /usr/local/bin/lein
COPY --from=clojure-lein /usr/share/java /usr/share/java

COPY --from=clojure-deps /usr/local/bin/clojure /usr/local/bin/clojure
COPY --from=clojure-deps /usr/local/bin/clj /usr/local/bin/clj
COPY --from=clojure-deps /usr/local/lib/clojure /usr/local/lib/clojure

COPY --from=rust /home/rust/.cargo/bin/bat /usr/local/bin/bat
COPY --from=rust /home/rust/.cargo/bin/exa /usr/local/bin/exa
COPY --from=rust /home/rust/.cargo/bin/fd /usr/local/bin/fd
COPY --from=rust /home/rust/.cargo/bin/rg /usr/local/bin/rg

COPY --from=go /usr/local/go/bin $GOROOT/bin
COPY --from=go /usr/local/go/src $GOROOT/src
COPY --from=go /usr/local/go/lib $GOROOT/lib
COPY --from=go /usr/local/go/pkg $GOROOT/pkg
COPY --from=go /usr/local/go/misc $GOROOT/misc
COPY --from=go /go/bin $GOROOT/bin

RUN mkdir $DOTFILES
WORKDIR $DOTFILES

COPY . .

# zplug plugins
RUN git clone https://github.com/zplug/zplug $HOME/.zplug \
    && git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zplug/repos/zsh-users/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-completions $HOME/.zplug/repos/zsh-users/zsh-completions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.zplug/repos/zsh-users/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/.zplug/repos/zsh-users/zsh-history-substring-search \
    && git clone https://github.com/greymd/tmux-xpanes $HOME/.zplug/repos/greymd/tmux-xpanes

RUN ["/bin/bash", "-c", "make -j4 deploy"]
RUN ["/bin/bash", "-c", "make prepare-init && make neovim-init && make tmux-init"]

RUN echo "[user]" > $HOME/.gitconfig.local \
    && echo "    name = Rintaro Okamura" >> $HOME/.gitconfig.local \
    && echo "    email = rintaro.okamura@gmail.com" >> $HOME/.gitconfig.local

WORKDIR $HOME

CMD ["zsh"]

