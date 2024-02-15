{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule {
  name = "jq-lsp";
  version = "unstable-2024-01-04";

  src = fetchFromGitHub {
    owner = "wader";
    repo = "jq-lsp";
    rev = "e4c63fd4a874ef1a42809669e09fac829f8e3083";
    hash = "sha256-gu9MLgvGX0V9VR0YCq0lGdHXIgN6uzRKVvCf/HfEJtk=";
  };

  vendorHash = "sha256-8sZGnoP7l09ZzLJqq8TUCquTOPF0qiwZcFhojUnnEIY=";
}
