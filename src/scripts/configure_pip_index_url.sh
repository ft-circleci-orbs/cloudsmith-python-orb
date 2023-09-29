#!/bin/bash

# shellcheck disable=SC2016
# shellcheck disable=SC2129

set +e

if [ -z "$CLOUDSMITH_PIP_INDEX_URL" ]
then
  echo "Unable to configure pip. Env var CLOUDSMITH_PIP_INDEX_URL is not defined."
  exit 1
fi

python -m pip config set global.index-url "$CLOUDSMITH_PIP_INDEX_URL"

echo "Pip index-url configured successfully for Cloudsmith repository: $CLOUDSMITH_REPOSITORY_IDENTIFIER"