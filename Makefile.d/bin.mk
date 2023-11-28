## --- [{:name "BAT_VERSION"
## ---   :url "https://api.github.com/repos/sharkdp/bat/releases"}
## ---  {:name "BB_VERSION"
## ---   :url "https://api.github.com/repos/babashka/babashka/releases"
## ---   :tx "(fn [x] (-> x (string/replace #\"v\" \"\")))"}
## ---  {:name "DELTA_VERSION"
## ---   :url "https://api.github.com/repos/dandavison/delta/releases"}
## ---  {:name "EXA_VERSION"
## ---   :url "https://api.github.com/repos/ogham/exa/releases"
## ---   :tx "(fn [x] (-> x (string/replace #\"exa \" \"\")))"}
## ---  {:name "FD_VERSION"
## ---   :url "https://api.github.com/repos/sharkdp/fd/releases"}
## ---  {:name "FZF_VERSION"
## ---   :url "https://api.github.com/repos/junegunn/fzf/releases"}
## ---  {:name "RG_VERSION"
## ---   :url "https://api.github.com/repos/BurntSushi/ripgrep/releases"}
## ---  {:name "SAD_VERSION"
## ---   :url "https://api.github.com/repos/ms-jpq/sad/releases"
## ---   :tx "(fn [x] (-> x (string/replace #\"ci_\" \"v\") (string/replace #\"_.*\" \"\")))"}]

BAT_VERSION := v0.24.0
BB_VERSION := 1.3.186
DELTA_VERSION := 0.16.5
EXA_VERSION := v0.10.1
FD_VERSION := v8.7.1
FZF_VERSION := 0.44.1
RG_VERSION := 14.0.2
SAD_VERSION := v0.4.23

.PHONY: install-bins
install-bins: \
	$(BINDIR) \
	$(BINDIR)/bat \
	$(BINDIR)/bb \
	$(BINDIR)/delta \
	$(BINDIR)/deno \
	$(BINDIR)/exa \
	$(BINDIR)/fd \
	$(BINDIR)/fzf \
	$(BINDIR)/fzf-tmux \
	$(BINDIR)/ghq \
	$(BINDIR)/k9s \
	$(BINDIR)/kubectx \
	$(BINDIR)/kubens \
	$(BINDIR)/jq \
	$(BINDIR)/rg \
	$(BINDIR)/sad \
	$(BINDIR)/xpanes \
	$(BINDIR)/yq
	@$(call green, "Maybe these binaries will be needed later:")
	@$(call green, "- git.zx2c4.com/password-store")
	@$(call green, "- docker/docker-credential-helpers")
	@$(call green, "- stern/stern")
	@$(call green, "- roboll/helmfile")
	@$(call green, "- kubernetes-sigs/kustomize")
	@$(call green, "- rohit-px2/nvui")

$(BINDIR):
	mkdir -p $(BINDIR)


$(BINDIR)/bat:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/bat.tar.gz https://github.com/sharkdp/bat/releases/download/$(BAT_VERSION)/bat-$(BAT_VERSION)-x86_64-apple-darwin.tar.gz
	tar xzvf /tmp/bat.tar.gz -C /tmp
	mv -f /tmp/bat-$(BAT_VERSION)-x86_64-apple-darwin/bat $(BINDIR)/bat
	rm -rf /tmp/bat.tar.gz /tmp/bat-$(BAT_VERSION)-x86_64-apple-darwin
else
	curl -sL -o /tmp/bat.tar.gz https://github.com/sharkdp/bat/releases/download/$(BAT_VERSION)/bat-$(BAT_VERSION)-x86_64-unknown-linux-musl.tar.gz
	tar xzvf /tmp/bat.tar.gz -C /tmp
	mv -f /tmp/bat-$(BAT_VERSION)-x86_64-unknown-linux-musl/bat $(BINDIR)/bat
	rm -rf /tmp/bat.tar.gz /tmp/bat-$(BAT_VERSION)-x86_64-unknown-linux-musl
endif

$(BINDIR)/bb:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/bb.tar.gz https://github.com/babashka/babashka/releases/download/v$(BB_VERSION)/babashka-$(BB_VERSION)-macos-amd64.tar.gz
	tar xzvf /tmp/bb.tar.gz -C /tmp
	mv -f /tmp/bb $(BINDIR)/bb
	rm -rf /tmp/bb.tar.gz
else
	curl -sL -o /tmp/bb.tar.gz https://github.com/babashka/babashka/releases/download/v$(BB_VERSION)/babashka-$(BB_VERSION)-linux-amd64-static.tar.gz
	tar xzvf /tmp/bb.tar.gz -C /tmp
	mv -f /tmp/bb $(BINDIR)/bb
	rm -rf /tmp/bb.tar.gz
endif

$(BINDIR)/delta:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/delta.tar.gz https://github.com/dandavison/delta/releases/download/$(DELTA_VERSION)/delta-$(DELTA_VERSION)-x86_64-apple-darwin.tar.gz
	tar xzvf /tmp/delta.tar.gz -C /tmp
	mv -f /tmp/delta-$(DELTA_VERSION)-x86_64-apple-darwin/delta $(BINDIR)/delta
	rm -rf /tmp/delta.tar.gz /tmp/delta-$(DELTA_VERSION)-x86_64-apple-darwin
else
	curl -sL -o /tmp/delta.tar.gz https://github.com/dandavison/delta/releases/download/$(DELTA_VERSION)/delta-$(DELTA_VERSION)-x86_64-unknown-linux-musl.tar.gz
	tar xzvf /tmp/delta.tar.gz -C /tmp
	mv -f /tmp/delta-$(DELTA_VERSION)-x86_64-unknown-linux-musl/delta $(BINDIR)/delta
	rm -rf /tmp/delta.tar.gz /tmp/delta-$(DELTA_VERSION)-x86_64-unknown-linux-musl
endif

$(BINDIR)/deno:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/deno.zip https://github.com/denoland/deno/releases/latest/download/deno-x86_64-apple-darwin.zip
	unzip -o /tmp/deno.zip -d $(BINDIR)/
else
	curl -sL -o /tmp/deno.zip https://github.com/denoland/deno/releases/latest/download/deno-x86_64-unknown-linux-gnu.zip
	unzip -o /tmp/deno.zip -d $(BINDIR)/
endif

$(BINDIR)/exa:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/exa.zip https://github.com/ogham/exa/releases/download/$(EXA_VERSION)/exa-macos-x86_64-$(EXA_VERSION).zip
	unzip -o /tmp/exa.zip -d /tmp/exa
	mv -f /tmp/exa/bin/exa $(BINDIR)/exa
	rm -rf /tmp/exa.zip /tmp/exa
else
	curl -sL -o /tmp/exa.zip https://github.com/ogham/exa/releases/download/$(EXA_VERSION)/exa-linux-x86_64-musl-$(EXA_VERSION).zip
	unzip -o /tmp/exa.zip -d /tmp/exa
	mv -f /tmp/exa/bin/exa $(BINDIR)/exa
	rm -rf /tmp/exa.zip /tmp/exa
endif

$(BINDIR)/fd:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/fd.tar.gz https://github.com/sharkdp/fd/releases/download/$(FD_VERSION)/fd-$(FD_VERSION)-x86_64-apple-darwin.tar.gz
	tar xzvf /tmp/fd.tar.gz -C /tmp
	mv -f /tmp/fd-$(FD_VERSION)-x86_64-apple-darwin/fd $(BINDIR)/fd
	rm -rf /tmp/fd.tar.gz /tmp/fd-$(FD_VERSION)-x86_64-apple-darwin
else
	curl -sL -o /tmp/fd.tar.gz https://github.com/sharkdp/fd/releases/download/$(FD_VERSION)/fd-$(FD_VERSION)-x86_64-unknown-linux-musl.tar.gz
	tar xzvf /tmp/fd.tar.gz -C /tmp
	mv -f /tmp/fd-$(FD_VERSION)-x86_64-unknown-linux-musl/fd $(BINDIR)/fd
	rm -rf /tmp/fd.tar.gz /tmp/fd-$(FD_VERSION)-x86_64-unknown-linux-musl
endif

$(BINDIR)/fzf:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/fzf.zip https://github.com/junegunn/fzf/releases/download/$(FZF_VERSION)/fzf-$(FZF_VERSION)-darwin_amd64.zip
	unzip -o /tmp/fzf.zip -d $(BINDIR)
	rm -rf /tmp/fzf.zip
else
	curl -sL -o /tmp/fzf.tar.gz https://github.com/junegunn/fzf/releases/download/$(FZF_VERSION)/fzf-$(FZF_VERSION)-linux_amd64.tar.gz
	tar xzvf /tmp/fzf.tar.gz -C $(BINDIR)
	rm -rf /tmp/fzf.tar.gz
endif

$(BINDIR)/fzf-tmux:
	curl -sL -o $(BINDIR)/fzf-tmux https://raw.githubusercontent.com/junegunn/fzf/master/bin/fzf-tmux
	chmod a+x $(BINDIR)/fzf-tmux

$(BINDIR)/ghq:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/ghq.zip https://github.com/x-motemen/ghq/releases/latest/download/ghq_darwin_amd64.zip
	unzip -o /tmp/ghq.zip -d /tmp/ghq
	mv -f /tmp/ghq/ghq_darwin_amd64/ghq $(BINDIR)/ghq
	rm -rf /tmp/ghq.tar.gz /tmp/ghq
else
	curl -sL -o /tmp/ghq.zip https://github.com/x-motemen/ghq/releases/latest/download/ghq_linux_amd64.zip
	unzip -o /tmp/ghq.zip -d /tmp/ghq
	mv -f /tmp/ghq/ghq_linux_amd64/ghq $(BINDIR)/ghq
	rm -rf /tmp/ghq.tar.gz /tmp/ghq
endif

$(BINDIR)/k9s:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Darwin_amd64.tar.gz
	tar xzvf /tmp/k9s.tar.gz -C /tmp
	mv -f /tmp/k9s $(BINDIR)/k9s
	rm -rf /tmp/k9s.tar.gz /tmp/LICENSE /tmp/README.md
else
	curl -sL -o /tmp/k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz
	tar xzvf /tmp/k9s.tar.gz -C /tmp
	mv -f /tmp/k9s $(BINDIR)/k9s
	rm -rf /tmp/k9s.tar.gz /tmp/LICENSE /tmp/README.md
endif

$(BINDIR)/kubectx:
	curl -sL -o $(BINDIR)/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
	chmod a+x $(BINDIR)/kubectx

$(BINDIR)/kubens:
	curl -sL -o $(BINDIR)/kubens https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
	chmod a+x $(BINDIR)/kubens

$(BINDIR)/jq:
ifeq ($(UNAME),Darwin)
	curl -sL -o $(BINDIR)/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-osx-amd64
	chmod a+x $(BINDIR)/jq
else
	curl -sL -o $(BINDIR)/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
	chmod a+x $(BINDIR)/jq
endif

$(BINDIR)/rg:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/rg.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/$(RG_VERSION)/ripgrep-$(RG_VERSION)-x86_64-apple-darwin.tar.gz
	tar xzvf /tmp/rg.tar.gz -C /tmp
	mv -f /tmp/ripgrep-$(RG_VERSION)-x86_64-apple-darwin/rg $(BINDIR)/rg
	rm -rf /tmp/rg.tar.gz /tmp/ripgrep-$(RG_VERSION)-x86_64-apple-darwin
else
	curl -sL -o /tmp/rg.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/$(RG_VERSION)/ripgrep-$(RG_VERSION)-x86_64-unknown-linux-musl.tar.gz
	tar xzvf /tmp/rg.tar.gz -C /tmp
	mv -f /tmp/ripgrep-$(RG_VERSION)-x86_64-unknown-linux-musl/rg $(BINDIR)/rg
	rm -rf /tmp/rg.tar.gz /tmp/ripgrep-$(RG_VERSION)-x86_64-unknown-linux-musl
endif

$(BINDIR)/sad:
ifeq ($(UNAME),Darwin)
	curl -sL -o /tmp/sad.zip https://github.com/ms-jpq/sad/releases/download/$(SAD_VERSION)/x86_64-apple-darwin.zip
	unzip -o /tmp/sad.zip -d /tmp/sad
	mv -f /tmp/sad/sad $(BINDIR)/sad
	rm -rf /tmp/sad.zip /tmp/sad
else
	curl -sL -o /tmp/sad.zip https://github.com/ms-jpq/sad/releases/download/$(SAD_VERSION)/x86_64-unknown-linux-musl.zip
	unzip -o /tmp/sad.zip -d /tmp/sad
	mv -f /tmp/sad/sad $(BINDIR)/sad
	rm -rf /tmp/sad.zip /tmp/sad
endif

$(BINDIR)/xpanes:
	curl -sL -o $(BINDIR)/xpanes https://raw.githubusercontent.com/greymd/tmux-xpanes/master/bin/xpanes
	chmod a+x $(BINDIR)/xpanes

$(BINDIR)/yq:
ifeq ($(UNAME),Darwin)
	curl -sL -o $(BINDIR)/yq https://github.com/mikefarah/yq/releases/latest/download/yq_darwin_amd64
	chmod a+x $(BINDIR)/yq
else
	curl -sL -o $(BINDIR)/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
	chmod a+x $(BINDIR)/yq
endif
