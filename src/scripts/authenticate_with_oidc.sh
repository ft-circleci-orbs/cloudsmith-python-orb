#!/bin/bash

# shellcheck disable=SC2016
# shellcheck disable=SC2129

set +e

if [ -z "$CLOUDSMITH_SERVICE_IDENTIFIER" ]
then
  echo "Unable to generate OIDC token. Environment variable CLOUDSMITH_SERVICE_IDENTIFIER is not set."
  exit 1
fi

echo "Generating Cloudsmith OIDC token for service account: $CLOUDSMITH_SERVICE_IDENTIFIER"

RESPONSE=$(curl -X POST -H "Content-Type: application/json" \
            -d "{\"oidc_token\":\"$CIRCLE_OIDC_TOKEN_V2\", \"service_slug\":\"$CLOUDSMITH_SERVICE_IDENTIFIER\"}" \
            --silent --show-error "https://api.cloudsmith.io/openid/financial-times/")

CLOUDSMITH_OIDC_TOKEN=$(echo "$RESPONSE" | grep -o '"token": "[^"]*' | grep -o '[^"]*$')

if [ -z "$CLOUDSMITH_OIDC_TOKEN" ]
then
  echo "Unable to generate OIDC token."
  echo "Response from Cloudsmith OIDC endpoint was: "
  echo "$RESPONSE"
  exit 1
else
  echo "Successfully generated OIDC token."
  echo ""

  echo "export CLOUDSMITH_OIDC_TOKEN=\"$CLOUDSMITH_OIDC_TOKEN\"" >> "$BASH_ENV"

  echo "The following environment variables have been exported. The OIDC token has been masked below."
  echo ""
  echo "CLOUDSMITH_SERVICE_IDENTIFIER=$CLOUDSMITH_SERVICE_IDENTIFIER"
  echo "CLOUDSMITH_OIDC_TOKEN=********"
fi
