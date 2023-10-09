{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule {
  name = "jq-lsp";
  version = "unstable-2023-09-08";

  src = fetchFromGitHub {
    owner = "wader";
    repo = "jq-lsp";
    rev = "85edf1adbe5e6c91b37c67b6a4bf85eda1e49f2f";
    hash = "sha256-ItLKRSbGZ8UqFEHCoh96KwhSpuKZ3l+2ZXnBkHEZL0M=";
  };

  vendorHash = "sha256-ppQ81uERHBgOr/bm/CoDSWcK+IqHwvcL6RFi0DgoLuw=";
}
