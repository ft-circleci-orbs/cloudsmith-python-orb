#!/bin/bash

# shellcheck disable=SC2016
# shellcheck disable=SC2129

set +e

if [ -z "$CLOUDSMITH_SERVICE_ACCOUNT" ] || [ -z "$CLOUDSMITH_OIDC_TOKEN" ]
then
  echo "Unable to find an OIDC token to use. Please ensure the cloudsmith-oidc/authenticate_with_oidc command has been run before this command."
  exit 1
fi

if [ -z "$CLOUDSMITH_ORGANISATION" ]
then
  echo "Unable to set environment variables for twine. Env var CLOUDSMITH_ORGANISATION is not defined."
  exit 1
fi

if [ -z "$CLOUDSMITH_REPOSITORY" ]
then
  echo "Unable to set environment variables for twine. Env var CLOUDSMITH_REPOSITORY is not defined."
  exit 1
fi

if [ -z "$CLOUDSMITH_PYTHON_UPLOAD_DOMAIN" ]
then
  echo "Unable to set environment variables for twine. Env var CLOUDSMITH_PYTHON_UPLOAD_DOMAIN is not defined."
  exit 1
fi

CLOUDSMITH_TWINE_REPOSITORY_URL="https://$CLOUDSMITH_PYTHON_UPLOAD_DOMAIN/$CLOUDSMITH_ORGANISATION/$CLOUDSMITH_REPOSITORY/"
CLOUDSMITH_TWINE_USERNAME="$CLOUDSMITH_SERVICE_ACCOUNT"
CLOUDSMITH_TWINE_PASSWORD="$CLOUDSMITH_OIDC_TOKEN"

echo "export CLOUDSMITH_TWINE_REPOSITORY_URL=\"$CLOUDSMITH_TWINE_REPOSITORY_URL\"" >> "$BASH_ENV"
echo "export CLOUDSMITH_TWINE_USERNAME=\"$CLOUDSMITH_TWINE_USERNAME\"" >> "$BASH_ENV"
echo "export CLOUDSMITH_TWINE_PASSWORD=\"$CLOUDSMITH_TWINE_PASSWORD\"" >> "$BASH_ENV"

echo "The following environment variables have been exported. Note, CLOUDSMITH_TWINE_PASSWORD has been masked below."
echo ""
echo "CLOUDSMITH_TWINE_REPOSITORY_URL=$CLOUDSMITH_TWINE_REPOSITORY_URL"
echo "CLOUDSMITH_TWINE_USERNAME=$CLOUDSMITH_TWINE_USERNAME"
echo "CLOUDSMITH_TWINE_PASSWORD=********"
