{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.2.5-0";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-4UrAiEYApdkZjabeyr6w47mxBE1nRBdx7hfQmkhJgCs=";
  };

  vendorHash = "sha256-M2nacX7XIg+Wcen5GDHK25VytpnFQCpQyix287h/ITA=";
}
