Icehouse Reference Module
=========================

This module is a reference implementation for the [cubbystack](https://github.com/jtopjian/puppet-cubbystack) OpenStack Module.

#### Table of Contents

1. [Introduction](#introduction)
2. [Setup](#setup)
  * [Requirements](#requirements)
3. [Usage](#usage)
  * [Module Installation](#module-installation)
  * [Hiera Configuration](#hiera-configuration)
  * [Roles](#roles)
4. [Limitations](#limitations)
5. [Credits](#credits)

## Introduction

This module is able to deploy a multi-node OpenStack environment out of the box. It currently supports two types of nodes:

  * Cloud Controller: Runs all services except for `nova-compute`
  * Compute Node: Runs `nova-compute`

In the future, this module will support more types as well as different variations on those types. Each type will probably be broken out into its own branch.

## Setup

### Requirements

  * This module has been tested with Ubuntu 14.04. Each node only requires one network interface, although support for three interfaces is included in the configuration.
  * Puppet 3.2+. You must also have the [future parser](http://docs.puppetlabs.com/puppet/3/reference/experiments_future.html) enabled.
  * Hiera 1.3.
  * The [cubbystack](https://github.com/jtopjian/puppet-cubbystack) module.

## Usage

### Module Installation

This module installs just like any other Puppet module. Make sure it is located in a correct `modulepath` directory such as `/etc/puppet/modules`.

### Hiera Configuration

This modules includes an example Hiera data file. If you'd like to use the example provided, copy the file such like:

```bash
$ sudo mkdir /etc/puppet/hieradata
$ sudo cp hiera/common.yaml /etc/puppet/hieradata/
```

Finally, review the `common.yaml` file and change any parameters that need modified to suit your environment.

### Roles

Once the module is installed and Hiera is configured, the last step is to apply a role to a node. This module comes with two roles: a cloud controller and compute node:

```puppet
node 'cloud.example.com' {
  include icehouse::roles::controller
}

node /c[0-9]+.example.com/ {
  include icehouse::roles::compute
}
```

## Limitations

This module is a reference module. Its purpose is to show you can use [cubbystack](https://github.com/jtopjian/cubbystack) in a practical way. Therefore this module will not cover all different types of OpenStack environments.

## Notes

Due to Neutron, you *must* hard-code the `services` project/tenant ID. See the `openstack::nova::keystone::tenant_id` setting in the Hiera file.

This module breaks some best practices by doing the whole roles/profiles thing *in* the module. If you want to conform to best practices, copy the contents of `manifests/*` to your local `site` or `admin` module *or* copy `manifests/profiles/*` to your `profiles` module and `manifests/roles/*` to your `roles` module. Or just leave it as-is.

Remember, this is a *reference* module. Its purpose is to get you started. Modify as needed.
