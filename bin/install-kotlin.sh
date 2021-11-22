#!/bin/bash

set -eu

cd /tmp \
&& curl -L "https://github.com/fwcd/kotlin-language-server/releases/latest/download/server.zip" --output kotlin-ls.zip \
&& unzip kotlin-ls.zip \
&& rm -f kotiln-ls.zip \
&& mv server /usr/local/kotlin-language-server \
&& ln -sf /usr/local/kotlin-language-server/bin/kotlin-language-server /usr/local/bin/kotlin-language-server
