export ZENO_HOME=$HOME/.dotfiles/zshrc.d/zeno

export ZENO_GIT_CAT="bat --color=always"
export ZENO_GIT_TREE="eza --tree"

if [[ -n $ZENO_LOADED ]]; then
  bindkey " " zeno-auto-snippet

  bindkey '^m' zeno-auto-snippet-and-accept-line

  bindkey '^i' zeno-completion

  bindkey '^x^p' zeno-insert-snippet

  bindkey '^x ' zeno-insert-space
  bindkey '^x^m' accept-line

  bindkey '^f' zeno-history-selection
  bindkey '^r' zeno-smart-history-selection
fi
