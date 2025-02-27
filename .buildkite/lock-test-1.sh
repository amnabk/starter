#!/bin/bash

echo "Step 1: Acquiring lock..."
LOCK_TOKEN=$(buildkite-agent lock acquire my-lock)

# Debug: Check if the token is being captured
echo "Step 1: Lock acquired with token: '$LOCK_TOKEN'"

# If LOCK_TOKEN is empty, print an error and exit
if [[ -z "$LOCK_TOKEN" ]]; then
  echo "❌ ERROR: Lock token is empty. Exiting."
  exit 1
fi

echo "Step 1: Sleeping for 60 seconds..."
sleep 60

echo "Step 1: Releasing lock..."
buildkite-agent lock release my-lock "$LOCK_TOKEN"
