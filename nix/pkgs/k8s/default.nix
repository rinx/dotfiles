{
  pkgs,
  ...
}:
with pkgs;
[
  k9s
  kubectl
  kubectx
  kubernetes-helm
  kustomize
]
