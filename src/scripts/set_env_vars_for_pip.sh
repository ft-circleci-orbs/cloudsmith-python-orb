#!/bin/bash

# shellcheck disable=SC2016
# shellcheck disable=SC2129

set +e

if [ -z "$CLOUDSMITH_SERVICE_ACCOUNT" ] || [ -z "$CLOUDSMITH_OIDC_TOKEN" ]
then
  echo "Unable to find an OIDC token to use. Please ensure the cloudsmith-oidc/authenticate_with_oidc command has been run before this command."
  exit 1
fi

if [ -z "$CLOUDSMITH_REPOSITORY" ]
then
  echo "Unable to set environment variables for pip. Env var CLOUDSMITH_REPOSITORY is not defined."
  exit 1
fi

if [ -z "$CLOUDSMITH_DOWNLOADS_DOMAIN" ]
then
  echo "Unable to set environment variables for pip. Env var CLOUDSMITH_DOWNLOADS_DOMAIN is not defined."
  exit 1
fi


CLOUDSMITH_PIP_INDEX_URL="https://$CLOUDSMITH_SERVICE_ACCOUNT:$CLOUDSMITH_OIDC_TOKEN@$CLOUDSMITH_DOWNLOADS_DOMAIN/basic/$CLOUDSMITH_REPOSITORY/python/simple/"

echo "export CLOUDSMITH_PIP_INDEX_URL=\"$CLOUDSMITH_PIP_INDEX_URL\"" >> "$BASH_ENV"

echo "The following environment variables have been exported. Note, the OIDC token has been masked below."
echo ""
echo "CLOUDSMITH_PIP_INDEX_URL=https://$CLOUDSMITH_SERVICE_ACCOUNT:********@$CLOUDSMITH_DOWNLOADS_DOMAIN/basic/$CLOUDSMITH_REPOSITORY/python/simple/"
