#!/bin/bash

set -eu

## GraalVM
GRAALVM_HOME=/usr/lib/graalvm
GRAALVM_VERSION=22.2.0

cd /tmp \
&& curl -sL "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz" --output graalvm.tar.gz \
&& mkdir -p ${GRAALVM_HOME} \
&& tar -xf graalvm.tar.gz -C ${GRAALVM_HOME} --strip-components=1 \
&& chmod -R a+rwx ${GRAALVM_HOME} \
&& rm -rf graalvm.tar.gz

## leiningen
curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein
chmod a+x /usr/local/bin/lein

echo "export JAVA_HOME=${GRAALVM_HOME}"
echo "export PATH=\$PATH:\$JAVA_HOME/bin"
