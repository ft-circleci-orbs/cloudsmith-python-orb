#!/bin/bash

# shellcheck disable=SC2016
# shellcheck disable=SC2129

if [ -d "$DIST_DIR" ]; then
  echo "$DIST_DIR is a valid directory."
else
  echo "$DIST_DIR is not a directory."
  exit 1
fi

for filename in "$DIST_DIR"/*.tar.gz
do
  [ -f "$filename" ] || continue

  echo "Uploading source distribution $filename to Cloudsmith repository $CLOUDSMITH_ORGANISATION/<<parameters.repository>> ..."

  cloudsmith push python --verbose --api-key "$CLOUDSMITH_OIDC_TOKEN" "$CLOUDSMITH_ORGANISATION/<<parameters.repository>>" "$filename"

  echo ""
  echo "Package upload and synchronisation completed OK."
done

for filename in "$DIST_DIR"/*.whl
do
  [ -f "$filename" ] || continue

  echo "Uploading wheel $filename to Cloudsmith repository $CLOUDSMITH_ORGANISATION/<<parameters.repository>> ..."

  cloudsmith push python --verbose --api-key "$CLOUDSMITH_OIDC_TOKEN" "$CLOUDSMITH_ORGANISATION/<<parameters.repository>>" "$filename"

  echo ""
  echo "Package upload and synchronisation completed OK."
done
