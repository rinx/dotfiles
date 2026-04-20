{
  lib,
  newScope,
  beamPackages,
  buildGleam,
  fetchgit,
}:

let
  inherit (beamPackages) buildMix buildRebar3 fetchHex;
in

lib.makeScope newScope (self: {
  argv = buildGleam {
    name = "argv";
    version = "1.0.2";
    otpApplication = "argv";

    src = fetchHex {
      pkg = "argv";
      version = "1.0.2";
      sha256 = "sha256-uh/wkpUl3roc5nJW5a33enzd/nKePj9Xpb3KoDHe0J0=";
    };
  };

  clip = buildGleam {
    name = "clip";
    version = "1.2.0";
    otpApplication = "clip";

    src = fetchHex {
      pkg = "clip";
      version = "1.2.0";
      sha256 = "sha256-/99VOdlnOZ0ixYqtvxdCPFa1UGBVpwZNKmYg7ZKOns8=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  filepath = buildGleam {
    name = "filepath";
    version = "1.1.2";
    otpApplication = "filepath";

    src = fetchHex {
      pkg = "filepath";
      version = "1.1.2";
      sha256 = "sha256-sGqa8L8Q5RQB1kuY5LYn8dLkjBVJZ9p69NCRR4Cm1Ao=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  gleam_erlang = buildGleam {
    name = "gleam_erlang";
    version = "1.3.0";
    otpApplication = "gleam_erlang";

    src = fetchHex {
      pkg = "gleam_erlang";
      version = "1.3.0";
      sha256 = "sha256-ESStOqIRQ+WvD8XPPZUp9tuMoD5DpVcRtgtrezh0N1w=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  gleam_otp = buildGleam {
    name = "gleam_otp";
    version = "1.2.0";
    otpApplication = "gleam_otp";

    src = fetchHex {
      pkg = "gleam_otp";
      version = "1.2.0";
      sha256 = "sha256-umopTileQo7BVi3BwR6nUw3LmB6DWRNL6ryEk7eyJY4=";
    };

    beamDeps = with self; [
      gleam_erlang
      gleam_stdlib
    ];
  };

  gleam_stdlib = buildGleam {
    name = "gleam_stdlib";
    version = "0.71.0";
    otpApplication = "gleam_stdlib";

    src = fetchHex {
      pkg = "gleam_stdlib";
      version = "0.71.0";
      sha256 = "sha256-cC87wqFHk5BogLEHixmmFl+HMjrujQxKNAhYRjNvyq4=";
    };
  };

  gleeunit = buildGleam {
    name = "gleeunit";
    version = "1.9.0";
    otpApplication = "gleeunit";

    src = fetchHex {
      pkg = "gleeunit";
      version = "1.9.0";
      sha256 = "sha256-2pVTzli2eSSzxjH5b+M3DEnrbW3Gs4TsSGLMSqpxjzw=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  shellout = buildGleam {
    name = "shellout";
    version = "1.8.0";
    otpApplication = "shellout";

    src = fetchHex {
      pkg = "shellout";
      version = "1.8.0";
      sha256 = "sha256-xBY1bUUVHymBCMnbnNHt4DE/Ygte27V2bNcjdlnYeEE=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  simplifile = buildGleam {
    name = "simplifile";
    version = "2.4.0";
    otpApplication = "simplifile";

    src = fetchHex {
      pkg = "simplifile";
      version = "2.4.0";
      sha256 = "sha256-fBivpP7QtM4fpbC0usH6F0RCcFTqmTVl9vP4LlRTFw0=";
    };

    beamDeps = with self; [
      filepath
      gleam_stdlib
    ];
  };
})
