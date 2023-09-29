# Cloudsmith CircleCI Orb

[![CircleCI Build Status](https://circleci.com/gh/ft-circleci-orbs/cloudsmith-circleci-orb.svg?style=shield&circle-token=c8aa8d7154df9de48a98c5231042bff7952b5fce)](https://circleci.com/gh/ft-circleci-orbs/cloudsmith-circleci-orb) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/ft-circleci-orbs/cloudsmith-circleci-orb/master/LICENSE)

A CircleCI orb to assist with downloading and publishing packages within your CircleCI projects.
This helper will load useful environment variables for you to use for accessing a Cloudsmith repository.

---

## Prerequisite Steps

### 1. The name of the Cloudsmith repository you wish to download or publish to.


**repository_identifier** 

This can be found in the [Cloudsmith UI](https://cloudsmith.io/~financial-times/repos/) under Repositories.
            

### 2. The Cloudsmith Service account identifier.


**service_identifier**

This can be found in the [Cloudsmith UI](https://cloudsmith.io/orgs/financial-times/accounts/services/) in Accounts under the Services tab.

---

## CircleCI Usage

### 1. Configure the Cloudsmith CircleCI Orb

Add the following to your CircleCI project config file (.circleci/config.yml) to make the cloudsmith-circleci orb available to use:

```yml
orbs:
    cloudsmith-circleci: financial-times/cloudsmith-circleci@1.0
```

### 2. Configure the Cloudsmith helper environment variables

Within a job configuration use the cloudsmith-circleci command ```setup_env_vars``` as follows:

```yml
jobs:
    install_python_dependencies_from_cloudsmith:
      docker:
        - image: cimg/python:current
      steps:
        - checkout
        - cloudsmith-circleci/setup_env_vars:
            repository_identifier: "your-repository-identifier"
            service_identifier: "your-service-identifier"
```
The above command will set several environment variables within the pipeline that can be used with the native language package managers to retrieve and publish packages to Cloudsmith.

- **CLOUDSMITH_OIDC_TOKEN**
- **CLOUDSMITH_PIP_INDEX_URL**
- **CLOUDSMITH_PYTHON_DOWNLOAD_REPOSITORY_URL**
- **CLOUDSMITH_REPOSITORY_IDENTIFIER**
- **CLOUDSMITH_SERVICE_IDENTIFIER**
  
### 3. Setup your own run commands to use your native package managment tools to access the repository.

Example of installing Python dependencies:

```yml
    steps:
        - run:
            name: Install Python dependencies
            command: pip install -r requirements.txt --index-url=$CLOUDSMITH_PYTHON_DOWNLOAD_REPOSITORY_URL
```
---

## Orb Commands

#### `cloudsmith-circleci/setup_env_vars`

Gets the Cloudsmith OIDC token, and returns this together with the environment variables.

---

## Additional Resources

Please refer to Cloudsmith's documentation for more information on their support for [OpenID](https://help.cloudsmith.io/docs/openid-connect)
