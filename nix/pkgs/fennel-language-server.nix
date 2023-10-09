{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  name = "fennel-language-server";
  version = "untagged-2023-06-29";

  src = fetchFromGitHub {
    owner = "rydesun";
    repo = "fennel-language-server";
    rev = "59005549ca1191bf2aa364391e6bf2371889b4f8";
    hash = "sha256-pp1+lquYRFZLHvU9ArkdLY/kBsfaHoZ9x8wAbWpApck=";
  };

  cargoHash = "sha256-B4JV1rgW59FYUuqjPzkFF+/T+4Gpr7o4z7Cmpcszcb8=";
}
