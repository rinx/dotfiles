FROM docker:dind AS docker

RUN mkdir -p /out

RUN cp /usr/local/bin/containerd /out
RUN cp /usr/local/bin/containerd-shim /out
RUN cp /usr/local/bin/ctr /out
RUN cp /usr/local/bin/docker /out
RUN cp /usr/local/bin/docker-init /out
RUN cp /usr/local/bin/docker-proxy /out
RUN cp /usr/local/bin/dockerd /out
RUN cp /usr/local/bin/runc /out

FROM clojure:lein-alpine AS clojure-lein

FROM clojure:tools-deps-alpine AS clojure-deps

FROM ekidd/rust-musl-builder:stable AS rust

RUN cargo install bat \
    exa \
    ripgrep \
    && cargo install --git https://github.com/sharkdp/fd

RUN mkdir -p /home/rust/out

RUN cp /home/rust/.cargo/bin/bat /home/rust/out
RUN cp /home/rust/.cargo/bin/exa /home/rust/out
RUN cp /home/rust/.cargo/bin/fd /home/rust/out
RUN cp /home/rust/.cargo/bin/rg /home/rust/out

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
    github.com/golangci/golangci-lint/cmd/golangci-lint \
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
    golang.org/x/tools/cmd/gopls \
    golang.org/x/tools/cmd/gorename \
    golang.org/x/tools/cmd/guru \
    honnef.co/go/tools/cmd/keyify \
    && gometalinter -i

RUN mkdir -p /out/usr/local/go
RUN mkdir -p /out/go
RUN cp -r /usr/local/go/bin /out/usr/local/go/bin
RUN cp -r /go/bin /out/go/bin

FROM alpine:edge AS packer

RUN apk update \
    && apk upgrade \
    && apk --update add --no-cache \
    upx

COPY --from=docker /out /out/docker
RUN upx --lzma --best /out/docker/*

COPY --from=rust /home/rust/out /out/rust
RUN upx --lzma --best /out/rust/*

COPY --from=go /out /out/go
RUN upx --lzma --best /out/go/usr/local/go/bin/*
RUN upx --lzma --best /out/go/go/bin/*

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
    git-email \
    git-perl \
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
    yarn \
    zsh \
    && rm -rf /var/cache/apk/*

RUN pip2 install --upgrade pip neovim \
    && pip3 install --upgrade pip neovim \
    && npm config set user root \
    && npm install -g neovim

RUN npm install -g \
    dockerfile-language-server-nodejs \
    bash-language-server

ENV HOME /root
ENV DOTFILES $HOME/.dotfiles

ENV LANG en_US.UTF-8
ENV TZ Asia/Tokyo
ENV SHELL /bin/zsh

ENV GOPATH $HOME/local
ENV GOROOT /usr/local/go
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

ENV PATH $PATH:$JAVA_HOME/jre/bin:$JAVA_HOME/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/bin

ENV DOCKER_BUILDKIT 1
ENV DOCKERIZED_DEVENV rinx/devenv

RUN mkdir -p $HOME/.ssh \
    && ssh-keyscan github.com >> $HOME/.ssh/known_hosts

COPY --from=docker /usr/local/bin/docker-entrypoint.sh /usr/bin/docker-entrypoint
COPY --from=docker /usr/local/bin/dind /usr/bin/dind
COPY --from=docker /usr/local/bin/modprobe /usr/bin/modprobe

COPY --from=packer /out/docker/containerd /usr/bin/docker-containerd
COPY --from=packer /out/docker/containerd-shim /usr/bin/docker-containerd-shim
COPY --from=packer /out/docker/ctr /usr/bin/docker-containerd-ctr
COPY --from=packer /out/docker/docker /usr/bin/docker
COPY --from=packer /out/docker/docker-init /usr/bin/docker-init
COPY --from=packer /out/docker/docker-proxy /usr/bin/docker-proxy
COPY --from=packer /out/docker/dockerd /usr/bin/dockerd
COPY --from=packer /out/docker/runc /usr/bin/docker-runc

COPY --from=clojure-lein /usr/local/bin/lein /usr/local/bin/lein
COPY --from=clojure-lein /usr/share/java /usr/share/java

COPY --from=clojure-deps /usr/local/bin/clojure /usr/local/bin/clojure
COPY --from=clojure-deps /usr/local/bin/clj /usr/local/bin/clj
COPY --from=clojure-deps /usr/local/lib/clojure /usr/local/lib/clojure

COPY --from=packer /out/rust/bat /usr/local/bin/bat
COPY --from=packer /out/rust/exa /usr/local/bin/exa
COPY --from=packer /out/rust/fd /usr/local/bin/fd
COPY --from=packer /out/rust/rg /usr/local/bin/rg

COPY --from=go /usr/local/go/src $GOROOT/src
COPY --from=go /usr/local/go/lib $GOROOT/lib
COPY --from=go /usr/local/go/pkg $GOROOT/pkg
COPY --from=go /usr/local/go/misc $GOROOT/misc

COPY --from=packer /out/go/usr/local/go/bin $GOROOT/bin
COPY --from=packer /out/go/go/bin $GOROOT/bin

RUN mkdir $DOTFILES
WORKDIR $DOTFILES

COPY coc-settings.json    $DOTFILES/coc-settings.json
COPY deps.edn             $DOTFILES/deps.edn
COPY dotvim               $DOTFILES/dotvim
COPY gitattributes_global $DOTFILES/gitattributes_global
COPY gitconfig            $DOTFILES/gitconfig
COPY gitignore            $DOTFILES/gitignore
COPY light.vimrc          $DOTFILES/light.vimrc
COPY Makefile             $DOTFILES/Makefile
COPY Makefile.d           $DOTFILES/Makefile.d
COPY nvimrc               $DOTFILES/nvimrc
COPY profiles.clj         $DOTFILES/profiles.clj
COPY resources            $DOTFILES/resources
COPY sway-config          $DOTFILES/sway-config
COPY tmux.conf            $DOTFILES/tmux.conf
COPY vimrc                $DOTFILES/vimrc
COPY vimshrc              $DOTFILES/vimshrc
COPY Xdefaults            $DOTFILES/Xdefaults
COPY zshrc                $DOTFILES/zshrc

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# zplug plugins
RUN git clone https://github.com/zplug/zplug $HOME/.zplug \
    && git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zplug/repos/zsh-users/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-completions $HOME/.zplug/repos/zsh-users/zsh-completions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.zplug/repos/zsh-users/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/.zplug/repos/zsh-users/zsh-history-substring-search \
    && git clone https://github.com/greymd/tmux-xpanes $HOME/.zplug/repos/greymd/tmux-xpanes

RUN mkdir -p /usr/share/skk \
    && wget -O /usr/share/skk/SKK-JISYO.L.gz http://openlab.jp/skk/dic/SKK-JISYO.L.gz \
    && gunzip /usr/share/skk/SKK-JISYO.L.gz

RUN ["/bin/bash", "-c", "make -j4 deploy"]
RUN ["/bin/bash", "-c", "make prepare-init && make neovim-init && make lightvim-init && make tmux-init"]

# download dependencies
RUN ["/bin/zsh", "-c", "lein"]
RUN ["/bin/zsh", "-c", "clojure -A:dev"]

WORKDIR $HOME

ENTRYPOINT ["docker-entrypoint"]
CMD ["zsh"]
