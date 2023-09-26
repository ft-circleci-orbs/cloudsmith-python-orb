#!/bin/bash

SERVICE_SLUG="code-management"

# Function to get a Cloudsmith API Key via OIDC
getOidcToken() {
  echo "Getting Cloudsmith API Key via OIDC..."
  RESPONSE=$(curl -X POST -H "Content-Type: application/json" -d "{\"oidc_token\":\"$CIRCLE_OIDC_TOKEN_V2\", \"service_slug\":\"$SERVICE_SLUG\"}" "https://api.cloudsmith.io/openid/financial-times/")
# Check if the response contains the "token" key
if [[ $RESPONSE == *'"token"'* ]]; then
  # If the "token" key is present, it's considered a success
  API_KEY=$(echo "$RESPONSE" | grep -o '"token": *"[^"]*"' | cut -d":" -f2 | tr -d '" ')
  echo "API key retrieved successfully"
  echo $API_KEY
else
  # If the "token" key is not present, it's considered an error`    `
  # Parse through response to get error
  error=$(echo "$RESPONSE" | grep -o '"detail": *"[^"]*"' | cut -d '"' -f 4 | tr -d '\n')
  echo "API request failed: $error"
fi
}


# configureEnvironment() {
#   # 
# }

# Retrieve Cloudsmith API key via OIDC
getOidcToken


# configureEnvironment()
