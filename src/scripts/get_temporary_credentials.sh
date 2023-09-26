#!/bin/bash

# shellcheck disable=SC2016
# shellcheck disable=SC2129

if [ -z "$CLOUDSMITH_SERVICE" ]
then
  echo "Unable to generate OIDC token. Environment variable CLOUDSMITH_SERVICE is not set."
  exit 1
fi

if [ -z "$CLOUDSMITH_REPOSITORY" ]
then
  echo "Unable to generate OIDC token. Environment variable CLOUDSMITH_REPOSITORY is not set."
  exit 1
fi

echo "Getting Cloudsmith OIDC token for: "
echo "CLOUDSMITH_SERVICE:     $CLOUDSMITH_SERVICE"
echo "CLOUDSMITH_REPOSITORY:  $CLOUDSMITH_REPOSITORY"
echo "..."

RESPONSE=$(curl -X POST -H "Content-Type: application/json" -d "{\"oidc_token\":\"$CIRCLE_OIDC_TOKEN_V2\", \"service_slug\":\"$CLOUDSMITH_SERVICE\"}" "https://api.cloudsmith.io/openid/financial-times/")

CLOUDSMITH_OIDC_TOKEN=$(echo "$RESPONSE" | grep -o '"token": "[^"]*' | grep -o '[^"]*$')

if [ -z "$CLOUDSMITH_OIDC_TOKEN" ]
then
  echo "Unable to generate OIDC token."
  echo "Response from Cloudsmith OIDC endpoint was: "
  echo "$RESPONSE"
  exit 1
else
  echo "Successfully generated OIDC token."

  CLOUDSMITH_PYTHON_REPOSITORY_URL="https://packages.ft.com/basic/$CLOUDSMITH_REPOSITORY/python/simple/"
  CLOUDSMITH_PIP_INDEX_URL="https://$CLOUDSMITH_SERVICE:$CLOUDSMITH_OIDC_TOKEN@packages.ft.com/basic/$CLOUDSMITH_REPOSITORY/python/simple/"

  echo "export CLOUDSMITH_PYTHON_REPOSITORY_URL=\"$CLOUDSMITH_PYTHON_REPOSITORY_URL\"" >> "$BASH_ENV"
  echo "export CLOUDSMITH_PIP_INDEX_URL=\"$CLOUDSMITH_PIP_INDEX_URL\"" >> "$BASH_ENV"
  echo "export CLOUDSMITH_OIDC_TOKEN=\"$CLOUDSMITH_OIDC_TOKEN\"" >> "$BASH_ENV"
  echo "export CLOUDSMITH_SERVICE=\"$CLOUDSMITH_SERVICE\"" >> "$BASH_ENV"
fi
