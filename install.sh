#!/bin/bash
PREFIX=/usr/local

cp sshg "${PREFIX}/bin/"
mkdir -p "${PREFIX}/share/man/man1"
cp sshg.1 "${PREFIX}/share/man/man1/"
