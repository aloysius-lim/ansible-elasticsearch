# Elasticsearch

[![Travis CI build status](https://api.travis-ci.org/abtpeople/ansible-elasticsearch.svg)](https://travis-ci.org/abtpeople/ansible-elasticsearch)

Ansible role to install Elasticsearch on Debian (Ubuntu) and Enterprise Linux (RedHat, CentOS) systems, with full configuration capabilities. This role uses the [official packages](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-repositories.html) from Elastic. It may also work on Fedora and Amazon Linux, but these have not been tested.

## Features

* Install any version of Elasticsearch that is available in the official repositories
* Fully configure Elasticsearch settings through variables
* Wait for Elasticsearch to be listening for connections before continuing with play

## Coming Soon

* Install plugins

## Status

Operating System | Release | Status                                                                                                                                                                                                    |
---------------- | ------- | ------                                                                                                                                                                                                    |
centos           | 6       | [![Vagrant passed](https://img.shields.io/badge/vagrant-passed-brightgreen.svg?style=flat-square)](#) [![Docker passed](https://img.shields.io/badge/docker-passed-brightgreen.svg?style=flat-square)](#) |
centos           | 7       | [![Vagrant passed](https://img.shields.io/badge/vagrant-passed-brightgreen.svg?style=flat-square)](#) [![Docker failed](https://img.shields.io/badge/docker-failed-red.svg?style=flat-square)](#)         |
debian           | wheezy  | [![Vagrant passed](https://img.shields.io/badge/vagrant-passed-brightgreen.svg?style=flat-square)](#) [![Docker failed](https://img.shields.io/badge/docker-failed-red.svg?style=flat-square)](#)         |
debian           | jessie  | [![Vagrant failed](https://img.shields.io/badge/vagrant-failed-red.svg?style=flat-square)](#)         [![Docker passed](https://img.shields.io/badge/docker-passed-brightgreen.svg?style=flat-square)](#) |
ubuntu           | precise | [![Vagrant passed](https://img.shields.io/badge/vagrant-passed-brightgreen.svg?style=flat-square)](#) [![Docker passed](https://img.shields.io/badge/docker-passed-brightgreen.svg?style=flat-square)](#) |
ubuntu           | trusty  | [![Vagrant passed](https://img.shields.io/badge/vagrant-passed-brightgreen.svg?style=flat-square)](#) [![Docker passed](https://img.shields.io/badge/docker-passed-brightgreen.svg?style=flat-square)](#) |

## Requirements
Java 7 or higher, as specified in the [Elasticsearch manual](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup.html#jvm-version). This role does not install Java; you may use your preferred role to install a suitable Java JRE on all Elasticsearch hosts.

## Role Variables

This role allows you to fully configure Elasticsearch using variables. Besides variables that control the behavior of the role, variables can also be set in `/etc/default/elasticsearch` and `/etc/elasticsearch/elasticsearch.yml`.

These variables control the behavior of the role:

* `es_release`: The release of Elasticsearch to install (default: `"1.5"`).
* `es_version`: The version of Elasticsearch to install (default: `"1.5.2"`).
* `es_wait_for_listen`: If set to true, whenever Elasticsearch is restarted, the playbook will wait for Elasticsearch to respond on port `es_etc_http_port` (default: `9200`) before proceeding (default: `"yes"`).

### /etc/default/elasticsearch

Variables in `/etc/default/elasticsearch` begin with `es_default_`. For example:

```yaml
---
es_default_es_user: es
es_default_es_group: es
```

will result in these lines in `/etc/default/elasticsearch`:

```ini
ES_USER=es
ES_GROUP=es
```

The full list of variables is in `templates/elasticsearch`. Custom variables not in the list can also be set by passing a dictionary called `es_default`, whose keys are variable names. For example, these variables:

```yaml
---
es_default:
  HELLO: world
  CUSTOM: variable
```

will produce:

```ini
HELLO=world
CUSTOM=variable
```

### /etc/elasticesarch/elasticsearch.yml

Similarly, the variables in `/etc/elasticesarch/elasticsearch.yml` can be fully configured by declaring variables starting with `es_etc_`. As before, you can look up the full list of variables in `templates/elasticsearch.yml`, and any variables not in that list can also be set through a dictionary `es_etc`. This is useful, for example, for setting obscure variables documented in the Elasticsearch reference manual, or variables for custom modules.

This example:

```yaml
---
es_etc_cluster_name: test_cluster
es_etc_index_number_of_shards: 3
es_etc:
  http.max_header_size: 16kB
  transport.tcp.connect_timeout: 20s
```

will produce these lines in `/etc/elasticsearch/elasticsearch.yml`:

```yaml
cluster.name: test_cluster
index.number_of_shards: 3
http.max_header_size: 16kB
transport.tcp.connect_timeout: 20s
```

## Example Playbook

```yaml
---
# Assume all nodes already have Java installed

# Master nodes
- hosts: elasticsearch_master
  roles:
    - role: elasticsearch
      es_default_heap_size: 8g
      es_etc_cluster_name: my_cluster
      es_etc_node_master: true
      es_etc_node_data: false

# Data nodes
- hosts: elasticsearch_data
  roles:
    - role: elasticsearch
      es_default_heap_size: 16g
      es_etc_cluster_name: my_cluster
      es_etc_node_master: false
      es_etc_node_data: true
```

# License

MIT

# Author Information

Aloysius Lim ([GitHub](https://github.com/aloysius-lim))

[About People](http://www.abtpeople.com/), a data science and design consultancy ([GitHub](https://github.com/abtpeople))
