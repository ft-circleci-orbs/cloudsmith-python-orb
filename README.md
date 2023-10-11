# Cloudsmith Python Orb

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/ft-circleci-orbs/cloudsmith-python-orb/tree/main.svg?style=svg&circle-token=66e39b994c3e883286179e5683fdfe6d3c9926d8)](https://dl.circleci.com/status-badge/redirect/gh/ft-circleci-orbs/cloudsmith-python-orb/tree/main) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/ft-circleci-orbs/cloudsmith-python-orb/master/LICENSE)

A CircleCI orb to assist with downloading python packages from and publishing python packages to Cloudsmith.

---

## Getting started

The orb commands require the following environment variables to be set:

* `CLOUDSMITH_ORGANISATION` : The identity/slug of the Cloudsmith organisation to use when authenticating with OIDC. Defaults to "financial-times" if not set.
* `CLOUDSMITH_SERVICE_ACCOUNT` : The identity/slug of the Cloudsmith service account to use when authenticating with OIDC.

These are used to authenticate with Cloudsmith using OIDC and can be found in the [Cloudsmith UI](https://cloudsmith.io/).

The orb provides commands to set environment variables for various package managment tools (e.g. pip) and to publish
packages using the Cloudsmith CLI.

---

## Documentation

Please see the [documention on the CircleCI orb registry](https://circleci.com/developer/orbs/orb/ft-circleci-orbs/cloudsmith-python).

---

