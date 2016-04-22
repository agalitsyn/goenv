#!/usr/bin/env bash

GO_ENV_FILENAME=".goenv"

function create-go-path() {
    cat > "$GO_ENV_FILENAME" <<EOF
export GOPATH=$(pwd)
export PATH=\$PATH:\$GOPATH/bin
export GO15VENDOREXPERIMENT=1
EOF

    cat >&2 <<EOF

To use it now, run:
    source $GO_ENV_FILENAME

To make it permanent, run:
    echo "source $(pwd)/$GO_ENV_FILENAME" >> ~/.bashrc
EOF
}


create-go-path

