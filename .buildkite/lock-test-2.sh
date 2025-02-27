#!/bin/bash

echo "Step 2: Trying to acquire lock..."
buildkite-agent lock acquire my-lock
echo "Step 2: Lock acquired!"
