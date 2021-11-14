#!/bin/bash

set -eu

apt update
apt install -y libxkbcommon-x11-dev libx11-xcb-dev '^libxcb.*-dev'
