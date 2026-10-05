#!/bin/zsh
set -euo pipefail

account="${USER:-ahmadullo}"

/usr/bin/security find-generic-password \
  -a "$account" \
  -s "codex-stitch-mcp" \
  -w 2>/dev/null \
  | /usr/bin/python3 -c 'import json, sys; print(json.dumps({"X-Goog-Api-Key": sys.stdin.read().rstrip("\n")}))'
