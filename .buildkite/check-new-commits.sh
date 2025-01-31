#!/bin/bash

git fetch origin Scheduledbuilds

if [[ $(git log -1 --format=%ct origin/Scheduledbuilds) -ge $(($(date +%s) - 86400)) ]]; then
  echo "New commits detected. Triggering build now."
  buildkite-agent pipeline upload
  exit 0
fi

echo "No new commits in the last 24 hours. Skipping build."
buildkite-agent annotate "No new commits in the last 24 hours. Skipping build." --style "warning"
exit 0
