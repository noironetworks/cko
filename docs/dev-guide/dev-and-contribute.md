# Contributing to CKO

## We Develop with Github
We use github to host code, to track issues and feature requests, as well as accept pull requests.

## We Use [Github Flow](https://guides.github.com/introduction/flow/index.html), So All Code Changes Happen Through Pull Requests
Pull requests are the best way to propose changes to the codebase (we use [Github Flow](https://guides.github.com/introduction/flow/index.html)). We actively welcome your pull requests:

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

# Developer guide

This document describes how to setup a development environemnt for Netop-org-manager, as well as how to build and test developed code.

## Prerequisites

These build instructions assume you have a Linux build environemnt with:

- Docker
- git
- make

## Checking out the code

Checkout the Netop-Org-Manager repository:

``` bash
git clone https://github.com/noironetworks/netop-org-manager.git
cd netop-org-manager
```

## Building

Build the operator binary and docker image:

``` bash
make build
make docker-build
```

## Testing

Run tests:

``` bash
make test
```

## Installing

Install on the local Kubernetes Cluster:

``` bash
make helm-deploy-local
```

## Uninstalling

Remove netop-org-manager:

``` bash
make helm-undeploy
```