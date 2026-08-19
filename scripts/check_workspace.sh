#!/usr/bin/env bash
set -euo pipefail

echo "=== BKK Community Platform Workspace Check ==="

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

CHECK_DIRS=(
  "apps/android"
  "apps/ios"
  "services/web"
  "database-reference"
  "docs"
  "reference"
  "scripts"
)

ERRORS=0

echo "Checking required top-level directories..."
for dir in "${CHECK_DIRS[@]}"; do
  if [ -d "$ROOT_DIR/$dir" ]; then
    echo "  [OK] $dir exists"
  else
    echo "  [FAIL] $dir is missing"
    ERRORS=$((ERRORS + 1))
  fi
done

echo ""
echo "Checking key project files..."
KEY_FILES=(
  "README.md"
  "GETTING_STARTED.md"
  "START_HERE.md"
  "services/web/public/index.php"
  "apps/android/build.gradle.kts"
  "apps/ios/Package.swift"
)

for file in "${KEY_FILES[@]}"; do
  if [ -f "$ROOT_DIR/$file" ]; then
    echo "  [OK] $file exists"
  else
    echo "  [FAIL] $file is missing"
    ERRORS=$((ERRORS + 1))
  fi
done

echo ""
if [ "$ERRORS" -eq 0 ]; then
  echo "All workspace directories and core project files are intact."
  exit 0
else
  echo "Workspace validation failed with $ERRORS missing items."
  exit 1
fi
