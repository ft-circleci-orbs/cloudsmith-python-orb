#!/bin/bash

if [ -z "$CLOUDSMITH_DOWNLOADS_DOMAIN" ]
then
  echo "export CLOUDSMITH_DOWNLOADS_DOMAIN=\"packages.ft.com\"" >> "$BASH_ENV"
  echo "CLOUDSMITH_DOWNLOADS_DOMAIN=$CLOUDSMITH_DOWNLOADS_DOMAIN"
fi

