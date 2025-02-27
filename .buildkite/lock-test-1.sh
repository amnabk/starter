#!/bin/bash

echo "Step 1: Acquiring lock..."
buildkite-agent lock my-lock

echo "Step 1: Lock acquired. Sleeping for 60 seconds..."
sleep 60

echo "Step 1: Releasing lock..."
buildkite-agent unlock my-lock
