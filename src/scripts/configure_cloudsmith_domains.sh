#!/bin/bash

if [ -z "$CLOUDSMITH_DOWNLOADS_DOMAIN" ]
then
  echo "export CLOUDSMITH_DOWNLOADS_DOMAIN=\"packages.ft.com\"" >> "$BASH_ENV"
fi

echo "export CLOUDSMITH_PYTHON_UPLOAD_DOMAIN=\"python.cloudsmith.io\"" >> "$BASH_ENV"

