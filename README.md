# go_ci

####Table of Contents

1. [Overview - What is the go_ci module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with go_ci](#setup)
4. [Supported on](#supported-on)


##Overview

The go_ci module allows you to setup go-server and go-agent to support continuous integration and continuous delivery on your project.

##Module Description

Go is a product that ThoughtWorks Studios (the product group of ThoughtWorks) has built over the last 6 years to support continuous delivery.
It helps create and manage automated deployment pipelines.
It supports automating the entire build-test-release process from check-in to deployment.
It is open-source, now freely available under a BSD-style license.
Here is the link to the [website](http://www.go.cd/)

##Setup

This module assumes that hiera is supported.
To install Go server and Go agent, following values are needed to be provided in hiera under the key 'go_ci'
    1. version
    2. build
    3. server_ip

For example,
```puppet
    go_ci:
        version: 14.1.0
        build: 18882
        server_ip: 127.0.0.1
```

To install Go server, just include following class in puppet manifest

```puppet
    include go_ci::server
```

Similarly to install Go agent, just include following class in puppet manifest

```puppet
    include go_ci::agent
```

##Supported On
This module works and has been tested on ubuntu-12.04 (64 bit)
