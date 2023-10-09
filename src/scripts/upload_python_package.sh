#!/bin/bash

# shellcheck disable=SC2016
# shellcheck disable=SC2129

# Check required environment variables are set and look valid
if [ -z "$CLOUDSMITH_ORGANISATION" ]
then
  echo "Unable to upload package. Env var CLOUDSMITH_ORGANISATION is not defined."
  exit 1
fi

if [ -z "$CLOUDSMITH_REPOSITORY" ]
then
  echo "Unable to upload package. Env var CLOUDSMITH_REPOSITORY is not defined."
  exit 1
fi

if [ -d "$DIST_DIR" ]; then
  echo "$DIST_DIR is a valid directory."
else
  echo "$DIST_DIR is not a directory."
  exit 1
fi

if [ -z "$(ls -A $DIST_DIR/*.tar.gz)" ] && [ -z "$(ls -A $DIST_DIR/*.whl)" ]
then
  echo "$DIST_DIR does not contain any tar.gz or whl files to upload."
  exit 1
fi

# Upload source distribution if present
for filename in "$DIST_DIR"/*.tar.gz
do
  [ -f "$filename" ] || continue

  echo "Uploading source distribution $filename to Cloudsmith repository $CLOUDSMITH_ORGANISATION/$CLOUDSMITH_REPOSITORY ..."

  cloudsmith push python --verbose --api-key "$CLOUDSMITH_OIDC_TOKEN" "$CLOUDSMITH_ORGANISATION/$CLOUDSMITH_REPOSITORY" "$filename"

  echo ""
  echo "Package upload and synchronisation completed OK."
done

# Upload wheel distribution(s) if present
for filename in "$DIST_DIR"/*.whl
do
  [ -f "$filename" ] || continue

  echo "Uploading wheel $filename to Cloudsmith repository $CLOUDSMITH_ORGANISATION/$CLOUDSMITH_REPOSITORY ..."

  cloudsmith push python --verbose --api-key "$CLOUDSMITH_OIDC_TOKEN" "$CLOUDSMITH_ORGANISATION/$CLOUDSMITH_REPOSITORY" "$filename"

  echo ""
  echo "Package upload and synchronisation completed OK."
done