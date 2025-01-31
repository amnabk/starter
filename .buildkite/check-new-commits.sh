#!/bin/bash

# Fetch the latest changes
git fetch origin Scheduledbuilds

# Get timestamps
LAST_COMMIT_TIME=$(git log -1 --pretty=format:%ct origin/Scheduledbuilds)
CURRENT_TIME=$(date +%s)
TIME_24_HOURS_AGO=$((CURRENT_TIME - 86400))

# Debugging: Print values to see what's happening
echo "Last commit timestamp: $LAST_COMMIT_TIME"
echo "Current time: $CURRENT_TIME"
echo "24 hours ago timestamp: $TIME_24_HOURS_AGO"

# Check if the last commit is within the last 24 hours
if [[ "$LAST_COMMIT_TIME" -lt "$TIME_24_HOURS_AGO" ]]; then
  echo "No new commits in the last 24 hours. Skipping build."
  buildkite-agent annotate "No new commits in the last 24 hours. Skipping build." --style "warning"
  exit 0  # Exit successfully so the pipeline stops early
fi

echo "New commits detected. Proceeding with the nightly build."
exit 1  # Non-zero exit allows dependent steps to run

