#!/usr/bin/env bash

set -eo pipefail

here="$(dirname "$0")"
src_root="$(readlink -f "${here}/..")"

# pacify shellcheck: cannot follow dynamic path
# shellcheck disable=SC1090,SC1091
source "$here"/no-std-crates.sh

cd "${src_root}"

# Use the wasm32v1-none target, which doesn't support std, but allows for alloc,
# to make sure that certain features work with no_std support.
target="wasm32v1-none"

./cargo check \
  "--target=$target" \
  --no-default-features \
  --features alloc,borsh,bytemuck,serde \
  "${no_std_crates[@]}"
