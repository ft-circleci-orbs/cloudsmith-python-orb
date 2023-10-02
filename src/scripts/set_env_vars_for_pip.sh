#!/bin/bash

# shellcheck disable=SC2016
# shellcheck disable=SC2129

set +e

if [ -z "$CLOUDSMITH_SERVICE_IDENTIFIER" ] || [ -z "$CLOUDSMITH_OIDC_TOKEN" ]
then
  echo "Unable to find an OIDC token to use. Please ensure the authenticate-with-oidc command has been run before this command."
  exit 1
fi

if [ -z "$CLOUDSMITH_REPOSITORY_IDENTIFIER" ]
then
  echo "Unable to set environment variables for pip. Env var CLOUDSMITH_REPOSITORY_IDENTIFIER is not defined."
  exit 1
fi

CLOUDSMITH_PIP_INDEX_URL="https://$CLOUDSMITH_SERVICE_IDENTIFIER:$CLOUDSMITH_OIDC_TOKEN@packages.ft.com/basic/$CLOUDSMITH_REPOSITORY_IDENTIFIER/python/simple/"

echo "export CLOUDSMITH_PIP_INDEX_URL=\"$CLOUDSMITH_PIP_INDEX_URL\"" >> "$BASH_ENV"

echo "The following environment variables have been exported. Note, the OIDC token has been masked below."
echo ""
echo "CLOUDSMITH_PIP_INDEX_URL=https://$CLOUDSMITH_SERVICE_IDENTIFIER:********@packages.ft.com/basic/$CLOUDSMITH_REPOSITORY_IDENTIFIER/python/simple/"
