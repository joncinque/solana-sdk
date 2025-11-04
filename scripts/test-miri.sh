#!/usr/bin/env bash

set -eo pipefail
here="$(dirname "$0")"
src_root="$(readlink -f "${here}/..")"
cd "${src_root}"
# miri is very slow; so only run very few of selective tests!
#
# Note: fixed version of solana-hash is needed here to avoid
#       dependency resolution issues since v3 just re-exports
#       v4 of the `solana-hash` crate.
./cargo nightly miri test -p solana-hash@3.0.0 -p solana-account-info
