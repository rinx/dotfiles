{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.2.5-2";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-L3YPcx3sCbRSPqAzJrGfcADJ1835lBjajFKQmVTnnRs=";
  };

  vendorHash = "sha256-Q5AXbxsxP4VIbLDa+9BnsGjLLn0Rso3y7hniK6ASoRg=";
}
