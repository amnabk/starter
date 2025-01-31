#!/bin/bash

# Fetch the latest commits
git fetch origin develop

# Get the timestamp of the latest commit on develop
LAST_COMMIT_TIME=$(git log -1 --pretty=format:%ct origin/develop)
CURRENT_TIME=$(date +%s)

# Calculate the timestamp for 24 hours ago
TIME_24_HOURS_AGO=$((CURRENT_TIME - 86400))

if [[ "$LAST_COMMIT_TIME" -lt "$TIME_24_HOURS_AGO" ]]; then
  echo "No new commits in the last 24 hours. Skipping build."
  buildkite-agent annotate "No new commits in the last 24 hours. Skipping build." --style "warning"
  exit 0  # Exit successfully so the pipeline doesn’t fail
fi

echo "New commits detected. Proceeding with the nightly build."
exit 1  # Non-zero exit ensures dependent steps run
