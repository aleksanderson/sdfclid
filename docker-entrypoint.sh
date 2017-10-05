#!/bin/bash

if [ "$1" = 'createproject' ]; then
    exec sdfcli-createproject "$@"
fi

exec sdfcli "$@"