# Cloudsmith CircleCI Orb

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/ft-circleci-orbs/cloudsmith-circleci-orb/tree/main.svg?style=svg&circle-token=66e39b994c3e883286179e5683fdfe6d3c9926d8)](https://dl.circleci.com/status-badge/redirect/gh/ft-circleci-orbs/cloudsmith-circleci-orb/tree/main) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/ft-circleci-orbs/cloudsmith-circleci-orb/master/LICENSE)

A CircleCI orb to assist with downloading from and publishing packages to Cloudsmith.

---

## Getting started

The orb commands need the following parameters:

* `repository_identifier` : The identity/slug of the Cloudsmith repository


* `service_identifier` : The identity/slug of the Cloudsmith service account to use when authenticating with OIDC

This can be found in the [Cloudsmith UI](https://cloudsmith.io/orgs/financial-times/).

The orb provides commands to set environment variables for various package managment tools (e.g. pip).

---

## Documentation

Please see the [documention on the CircleCI orb registry](https://circleci.com/developer/orbs/orb/ft-circleci-orbs/cloudsmith-circleci).


### Supported Package Management Tools

**Python:** pip

---

