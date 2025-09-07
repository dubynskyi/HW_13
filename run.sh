#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
python3 -m venv .venv 2>/dev/null || true
source .venv/bin/activate
python -m pip install --upgrade pip
pip install "dbt-core>=1.6,<1.8" "dbt-duckdb>=1.6,<1.8"
dbt build --profiles-dir .
dbt docs generate --profiles-dir .
echo "Done."
