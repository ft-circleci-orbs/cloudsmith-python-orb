#!/bin/bash

# shellcheck disable=SC2016
# shellcheck disable=SC2129

set +e

if [ -z "$CLOUDSMITH_SERVICE_ID" ]
then
  echo "Unable to generate OIDC token. Environment variable CLOUDSMITH_SERVICE_IDENTIFIER is not set."
  exit 1
fi

if [ -z "$CLOUDSMITH_REPOSITORY_IDENTIFIER" ]
then
  echo "Unable to generate OIDC token. Environment variable CLOUDSMITH_REPOSITORY_IDENTIFIER is not set."
  exit 1
fi

echo "Getting Cloudsmith OIDC token for: "
echo "CLOUDSMITH_SERVICE_IDENTIFIER:     $CLOUDSMITH_SERVICE_IDENTIFIER"
echo "CLOUDSMITH_REPOSITORY_IDENTIFIER:  $CLOUDSMITH_REPOSITORY_IDENTIFIER"
echo "..."

RESPONSE=$(curl -X POST -H "Content-Type: application/json" -d "{\"oidc_token\":\"$CIRCLE_OIDC_TOKEN_V2\", \"service_slug\":\"$CLOUDSMITH_SERVICE_IDENTIFIER\"}" --silent --show-error "https://api.cloudsmith.io/openid/financial-times/")

CLOUDSMITH_OIDC_TOKEN=$(echo "$RESPONSE" | grep -o '"token": "[^"]*' | grep -o '[^"]*$')

if [ -z "$CLOUDSMITH_OIDC_TOKEN" ]
then
  echo "Unable to generate OIDC token."
  echo "Response from Cloudsmith OIDC endpoint was: "
  echo "$RESPONSE"
  exit 1
else
  echo "Successfully generated OIDC token."

  CLOUDSMITH_PYTHON_REPOSITORY_URL="https://packages.ft.com/basic/$CLOUDSMITH_REPOSITORY_IDENTIFIER/python/simple/"
  CLOUDSMITH_PIP_INDEX_URL="https://$CLOUDSMITH_SERVICE_IDENTIFIER:$CLOUDSMITH_OIDC_TOKEN@packages.ft.com/basic/$CLOUDSMITH_REPOSITORY_IDENTIFIER/python/simple/"

  echo "export CLOUDSMITH_OIDC_TOKEN=\"$CLOUDSMITH_OIDC_TOKEN\"" >> "$BASH_ENV"
  echo "export CLOUDSMITH_PYTHON_REPOSITORY_URL=\"$CLOUDSMITH_PYTHON_REPOSITORY_URL\"" >> "$BASH_ENV"
  echo "export CLOUDSMITH_PIP_INDEX_URL=\"$CLOUDSMITH_PIP_INDEX_URL\"" >> "$BASH_ENV"

  echo "The following Cloudsmith environment variables have been exported successfully."
  echo "CLOUDSMITH_OIDC_TOKEN=********"
  echo "CLOUDSMITH_PIP_INDEX_URL=https://$CLOUDSMITH_SERVICE_IDENTIFIER:********@packages.ft.com/basic/$CLOUDSMITH_REPOSITORY_IDENTIFIER/python/simple/"
  echo "CLOUDSMITH_PYTHON_REPOSITORY_URL=$CLOUDSMITH_PYTHON_REPOSITORY_URL"
  echo "CLOUDSMITH_REPOSITORY_IDENTIFIER=$CLOUDSMITH_REPOSITORY_IDENTIFIER"
  echo "CLOUDSMITH_SERVICE_IDENTIFIER=$CLOUDSMITH_SERVICE_IDENTIFIER"
fi
