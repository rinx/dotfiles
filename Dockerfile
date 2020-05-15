ARG GRAALVM_VERSION=20.0.0
ARG GRAALVM_JAVA_VERSION=java11

ARG RIPGREP_VERSION=11.0.1
ARG BAT_VERSION=v0.12.1

ARG KIND_VERSION=v0.7.0
ARG STERN_VERSION=1.11.0
ARG K9S_VERSION=v0.19.4
ARG HELMFILE_VERSION=v0.116.0
ARG KUSTOMIZE_VERSION=v3.5.5

ARG PROTOBUF_VERSION=3.11.4
ARG KOTLIN_LS_VERSION=0.5.2

ARG BABASHKA_VERSION=0.0.93
ARG JET_VERSION=0.0.12
ARG CLJ_KONDO_VERSION=2020.04.05
ARG VALDCLI_VERSION=v0.0.34

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

FROM ekidd/rust-musl-builder:latest AS rust
ARG RIPGREP_VERSION
ARG BAT_VERSION

# RUN cargo install bat \
#     exa \
RUN cargo install exa \
    && cargo install --version ${RIPGREP_VERSION} ripgrep \
    && cargo install --git https://github.com/sharkdp/fd
RUN curl -o bat-${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz -L https://github.com/sharkdp/bat/releases/download/${BAT_VERSION}/bat-${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz \
    && tar xzvf bat-${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz \
    && cp bat-${BAT_VERSION}-x86_64-unknown-linux-musl/bat /home/rust/.cargo/bin/bat

RUN mkdir -p /home/rust/out

RUN cp /home/rust/.cargo/bin/bat /home/rust/out
RUN cp /home/rust/.cargo/bin/exa /home/rust/out
RUN cp /home/rust/.cargo/bin/fd  /home/rust/out
RUN cp /home/rust/.cargo/bin/rg  /home/rust/out

FROM golang:alpine AS go

RUN apk update \
    && apk upgrade \
    && apk --update-cache add --no-cache \
    git \
    curl \
    gcc \
    musl-dev \
    wget

ENV GO111MODULE on
RUN go get -v -u \
    github.com/davidrjenni/reftools/cmd/fillstruct \
    github.com/fullstorydev/grpcurl/cmd/grpcurl \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/junegunn/fzf \
    github.com/mikefarah/yq/v3 \
    github.com/x-motemen/ghq \
    golang.org/x/lint/golint \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/tools/cmd/gorename \
    golang.org/x/tools/cmd/guru
RUN go get \
    golang.org/x/tools/gopls@latest \
    github.com/sasha-s/goimpl/cmd/goimpl

RUN mkdir -p /out/usr/local/go
RUN mkdir -p /out/go
RUN cp -r /usr/local/go/bin /out/usr/local/go/bin
RUN cp -r /go/bin /out/go/bin

FROM alpine:edge AS kube
ARG KIND_VERSION
ARG STERN_VERSION
ARG K9S_VERSION
ARG HELMFILE_VERSION
ARG KUSTOMIZE_VERSION

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
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /out/kube/kubectl \
    && chmod a+x /out/kube/kubectl \
    && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash \
    && mv /usr/local/bin/helm /out/packer/helm \
    && curl -L https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-$(uname)-amd64 -o /out/packer/kind \
    && chmod a+x /out/packer/kind \
    && git clone --depth=1 https://github.com/ahmetb/kubectx /opt/kubectx \
    && mv /opt/kubectx/kubectx /out/kube/kubectx \
    && mv /opt/kubectx/kubens /out/kube/kubens \
    && curl -L https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64 -o /out/packer/stern \
    && chmod a+x /out/packer/stern \
    && curl -sL https://run.linkerd.io/install | sh \
    && mv /root/.linkerd2/bin/linkerd-* /out/packer/linkerd \
    && curl -L https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_x86_64.tar.gz -o k9s.tar.gz \
    && tar xzvf k9s.tar.gz \
    && mv k9s /out/packer/k9s \
    && curl -L https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64 -o /out/packer/helmfile \
    && chmod a+x /out/packer/helmfile \
    && curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz -o kustomize.tar.gz \
    && tar xzvf kustomize.tar.gz \
    && mv kustomize /out/packer/kustomize

FROM alpine:edge AS packer

RUN apk update \
    && apk upgrade \
    && apk --update-cache add --no-cache \
    upx

COPY --from=docker /out /out/docker
RUN upx --lzma --best /out/docker/*

COPY --from=rust /home/rust/out /out/rust
RUN upx --lzma --best /out/rust/*

COPY --from=go /out /out/go
RUN upx --lzma --best /out/go/usr/local/go/bin/*
RUN upx --lzma --best /out/go/go/bin/*

COPY --from=kube /out/packer /out/kube
RUN upx --lzma --best /out/kube/*

FROM ubuntu:devel AS base

LABEL maintainer "Rintaro Okamura <rintaro.okamura@gmail.com>"
ARG GRAALVM_VERSION
ARG GRAALVM_JAVA_VERSION
ARG PROTOBUF_VERSION
ARG KOTLIN_LS_VERSION
ARG BABASHKA_VERSION
ARG JET_VERSION
ARG CLJ_KONDO_VERSION
ARG VALDCLI_VERSION

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TZ Asia/Tokyo
ENV DEBIAN_FRONTEND noninteractive

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
    musl-dev \
    neovim \
    nodejs \
    npm \
    openssh-client \
    openssh-server \
    openssl \
    perl \
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
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip neovim \
    && npm config set user root \
    && npm install -g neovim

RUN npm install -g \
    dockerfile-language-server-nodejs \
    bash-language-server \
    && pip3 install \
    fortran-language-server

ENV GRAALVM_HOME /usr/lib/graalvm
RUN cd /tmp \
    && curl -sL "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_JAVA_VERSION}-linux-amd64-${GRAALVM_VERSION}.tar.gz" --output graalvm.tar.gz \
    && mkdir -p ${GRAALVM_HOME} \
    && tar -xf graalvm.tar.gz -C ${GRAALVM_HOME} --strip-components=1 \
    && chmod -R a+rwx ${GRAALVM_HOME} \
    && rm -rf graalvm.tar.gz \
    && upx --lzma --best /usr/lib/graalvm/bin/polyglot \
    && upx --lzma --best /usr/lib/graalvm/languages/js/bin/js \
    && upx --lzma --best /usr/lib/graalvm/languages/js/bin/node \
    && upx --lzma --best /usr/lib/graalvm/languages/llvm/bin/lli

RUN cd /tmp \
    && curl -OL "https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip" \
    && unzip protoc-${PROTOBUF_VERSION}-linux-x86_64.zip -d protoc3 \
    && upx --lzma --best protoc3/bin/* \
    && mv protoc3/bin/* /usr/local/bin/ \
    && mv protoc3/include/* /usr/local/include/ \
    && rm -rf protoc-${PROTOBUF_VERSION}-linux-x86_64.zip protoc3

RUN cd /tmp \
    && curl -L "https://github.com/fwcd/kotlin-language-server/releases/download/${KOTLIN_LS_VERSION}/server.zip" --output kotlin-ls.zip \
    && unzip kotlin-ls.zip \
    && rm -f kotiln-ls.zip \
    && mv server /usr/local/kotlin-language-server \
    && ln -sf /usr/local/kotlin-language-server/bin/kotlin-language-server /usr/local/bin/kotlin-language-server

RUN cd /tmp \
    && curl -OL "https://github.com/vdaas/vald-client-clj/releases/download/${VALDCLI_VERSION}/valdcli-linux-static.zip" \
    && unzip valdcli-linux-static.zip \
    && rm -f valdcli-linux-static.zip \
    && chmod a+x valdcli \
    && mv valdcli /usr/local/bin/

RUN cd /tmp \
    && curl -L "https://github.com/borkdude/babashka/releases/download/v${BABASHKA_VERSION}/babashka-${BABASHKA_VERSION}-linux-amd64.zip" --output babashka.zip \
    && unzip babashka.zip \
    && rm -f babashka.zip \
    && chmod a+x bb \
    && upx --lzma --best bb \
    && mv bb /usr/local/bin/

RUN cd /tmp \
    && curl -L "https://github.com/borkdude/jet/releases/download/v${JET_VERSION}/jet-${JET_VERSION}-linux-amd64.zip" --output jet.zip \
    && unzip jet.zip \
    && rm -f jet.zip \
    && chmod a+x jet \
    && upx --lzma --best jet \
    && mv jet /usr/local/bin/

RUN cd /tmp \
    && curl -L "https://github.com/borkdude/clj-kondo/releases/download/v${CLJ_KONDO_VERSION}/clj-kondo-${CLJ_KONDO_VERSION}-linux-amd64.zip" --output clj-kondo.zip \
    && unzip clj-kondo.zip \
    && rm -f clj-kondo.zip \
    && chmod a+x clj-kondo \
    && upx --lzma --best clj-kondo \
    && mv clj-kondo /usr/local/bin/

ENV HOME /root
ENV DOTFILES $HOME/.dotfiles

ENV SHELL /bin/zsh

ENV GOPATH $HOME/local
ENV GOROOT /usr/local/go
ENV JAVA_HOME ${GRAALVM_HOME}

ENV PATH $PATH:$JAVA_HOME/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/bin:$HOME/.config/lightvim/plugged/vim-iced/bin

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

COPY --from=packer /out/rust/bat /usr/local/bin/bat
COPY --from=packer /out/rust/exa /usr/local/bin/exa
COPY --from=packer /out/rust/fd  /usr/local/bin/fd
COPY --from=packer /out/rust/rg  /usr/local/bin/rg

COPY --from=go /usr/local/go/src  $GOROOT/src
COPY --from=go /usr/local/go/lib  $GOROOT/lib
COPY --from=go /usr/local/go/pkg  $GOROOT/pkg
COPY --from=go /usr/local/go/misc $GOROOT/misc

COPY --from=packer /out/go/usr/local/go/bin $GOROOT/bin
COPY --from=packer /out/go/go/bin           $GOROOT/bin

COPY --from=kube /out/kube/kubectx /usr/local/bin/kubectx
COPY --from=kube /out/kube/kubens  /usr/local/bin/kubens
COPY --from=kube /out/kube/kubectl /usr/local/bin/kubectl

COPY --from=packer /out/kube/helm      /usr/local/bin/helm
COPY --from=packer /out/kube/kind      /usr/local/bin/kind
COPY --from=packer /out/kube/stern     /usr/local/bin/stern
COPY --from=packer /out/kube/linkerd   /usr/local/bin/linkerd
COPY --from=packer /out/kube/k9s       /usr/local/bin/k9s
COPY --from=packer /out/kube/helmfile  /usr/local/bin/helmfile
COPY --from=packer /out/kube/kustomize /usr/local/bin/kustomize

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
COPY tmux.conf            $DOTFILES/tmux.conf
COPY vimrc                $DOTFILES/vimrc
COPY zshrc                $DOTFILES/zshrc

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && locale-gen --purge $LANG

# zplug plugins
RUN git clone https://github.com/zplug/zplug $HOME/.zplug \
    && git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zplug/repos/zsh-users/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-completions $HOME/.zplug/repos/zsh-users/zsh-completions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.zplug/repos/zsh-users/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/.zplug/repos/zsh-users/zsh-history-substring-search \
    && git clone https://github.com/greymd/tmux-xpanes $HOME/.zplug/repos/greymd/tmux-xpanes

# babashka classpath
RUN export BABASHKA_CLASSPATH=$(clojure -Sdeps '{:deps {limit-break {:git/url "https://github.com/borkdude/clj-http-lite" :sha "f44ebe45446f0f44f2b73761d102af3da6d0a13e"}}}' -Spath)

RUN ["/bin/bash", "-c", "make -j4 deploy"]
RUN ["/bin/bash", "-c", "make prepare-init && make neovim-init && make lightvim-init && make tmux-init"]

# download dependencies
RUN ["/bin/zsh", "-c", "lein"]
RUN ["/bin/zsh", "-c", "clojure -A:dev"]

RUN rm -rf /tmp/*

WORKDIR $HOME

ENTRYPOINT ["docker-entrypoint"]
CMD ["zsh"]
