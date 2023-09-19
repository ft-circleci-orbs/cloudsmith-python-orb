#!/bin/bash

# Function to get a Cloudsmith API Key via OIDC
getOidcToken() {
  echo "Getting Cloudsmith API Key via OIDC..."
  RESPONSE=$(curl -X POST -H "Content-Type: application/json" -d "{\"oidc_token\":\"$CIRCLE_OIDC_TOKEN_V2\", \"service_slug\":\"$SERVICE_SLUG\"}" "https://api.cloudsmith.io/openid/financial-times/")
# Check if the response contains the "token" key
if [[ $RESPONSE == *'"token"'* ]]; then
  # If the "token" key is present, it's considered a success
  API_KEY=$(echo "$RESPONSE" | grep -o '"token": *"[^"]*"' | cut -d":" -f2 | tr -d '" ')
  echo "API key retrieved successfully"
else
  # If the "token" key is not present, it's considered an error`    `
  # Parse through response to get error
  error=$(echo "$RESPONSE" | grep -o '"detail": *"[^"]*"' | cut -d '"' -f 4 | tr -d '\n')
  echo "API request failed: $error"
fi
}

# Function to configure pip for Cloudsmith
configurePip() {
    # Check if pip is installed and pip config
    if command -v pip &> /dev/null; then
    pip config --user set global.index-url https://$SERVICE_SLUG:$API_KEY@packages.ft.com/basic/$REPOSITORY/python/simple/
else
    echo "Error, pip is not installed. Exiting..."
fi
}

# Retrieve Cloudsmith API key via OIDC
getOidcToken

# Configure Pip
configurePip
