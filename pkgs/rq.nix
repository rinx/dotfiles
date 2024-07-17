{
  lib,
  buildGoModule,
  fetchFromSourcehut,
}:
buildGoModule rec {
  name = "rq";
  version = "0.0.9";

  src = fetchFromSourcehut {
    owner = "~charles";
    repo = "rq";
    rev = "v${version}";
    hash = "sha256-ak0whlawHj1BkiZ31/agdadHB1ykQSqa6avESZA0RGA=";
  };

  vendorHash = "sha256-lNUsaM7e1IsJYQFwlkhumo8i9ExOp96Li1Nszv4ce18=";
}
