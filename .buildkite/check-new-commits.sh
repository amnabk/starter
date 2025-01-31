#!/bin/bash

git fetch origin Scheduledbuilds

# Exit early if not a scheduled build
if [[ "$BUILDKITE_SOURCE" != "schedule" ]]; then
  exit 0
fi

# Check if the last commit was within the last 24 hours
if [[ $(git log -1 --format=%ct origin/Scheduledbuilds) -ge $(($(date +%s) - 86400)) ]]; then
  echo "New commits detected. Triggering build steps."
  
  # Upload empty pipeline steps for customization
  cat <<EOF | buildkite-agent pipeline upload
steps:
  - label: ":construction_worker: Build"
    command: echo "Building..."
  - label: ":white_check_mark: Test"
    command: echo "Testing..."
  - label: ":rocket: Deploy"
    command: echo "Deploying..."
EOF

  exit 0
fi

# No new commits detected, annotate and exit successfully
buildkite-agent annotate "No new commits in the last 24 hours. Skipping build." --style "warning"
exit 0
