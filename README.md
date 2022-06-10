<p align="center">
  <a href="https://github.com/SergeyIvanovDevelop/MongoDB-Cluster-TLS">
    <img alt="Social-Contract" src="./resources/logo.png" width="280" height="280"/>
  </a>
</p>
<h1 align="center">
  MongoDB-Cluster-TLS
</h1>

## MongoDB-Cluster-TLS &middot; [![GitHub license](https://img.shields.io/badge/license-CC%20BY--NC--SA%203.0-blue)](./LICENSE) [![TLS](https://img.shields.io/badge/security-tls-green)](https://en.wikipedia.org/wiki/Transport_Layer_Security) [![MongoDB](https://img.shields.io/badge/db-MongoDB-red)](https://www.mongodb.com/) [![Docker](https://img.shields.io/badge/container-docker-informational)](https://www.docker.com/) [![LinkedIn](https://img.shields.io/badge/linkedin-Sergey%20Ivanov-blue)](https://www.linkedin.com/in/sergey-ivanov-33413823a/) [![Telegram](https://img.shields.io/badge/telegram-%40SergeyIvanov__dev-blueviolet)](https://t.me/SergeyIvanov_dev) ##

This repository contains the configuration for deploying a `NoSQL` cluster of a `MongoDB` database with sharding and replication. Connections between all shards in a replica are authenticated using `x509` certificates and communicate with each other over a `TLS` connection. Communication between replicas occurs in a similar way. Communications with `Config Server` and `MongoS` are protected in a similar way. The client side connection to `MongoS` is protected in a similar way.

This project automatically deploys a `MongoDB` cluster in `Docker` containers, creates its own certificate authority, generates and distributes authentication keys and keys for a `TLS` connection for each element of the `MongoDB` cluster, as well as for a client that will connect to `MongoS`. The cluster consists of a `MongoS` router, three `Config Server`, three replicas, each with 3 shards.

The general scheme of the `MongoDB` cluster is shown in the image: <br>

<p align="center">
<img src="./resources/scheme.png"/>
</p>

## :computer: Getting Started  ##

**Step 1**

1. Go to home directory and clone repository from github: `cd ~ && git clone https://SergeyIvanovDevelop@github.com/SergeyIvanovDevelop/MongoDB-Cluster-TLS`

**Step 2**<br>

2. Go to the directory of the downloaded repository: `cd ~/MongoDB-Cluster-TLS`

**Step 3**<br>

3. You must have installed [openssl](https://www.openssl.org/), [docker](https://www.docker.com/), [docker-compose](https://docs.docker.com/compose/install/) and [MongoDB](https://www.mongodb.com/). 

**Step 4**<br>

4. You need to build `Docker` images/containers and generate keys: `./run_all.sh build`

**Step 5**<br>

5. You need to recreate/run `Docker` containers: `./run_all.sh run`

**Step 6**<br>

6. Check the connection from the client with `MongoS`: `./connect_tls_to_mongos.sh`

If you manage to enter the `MongoDB` command line, then everything is done correctly and the cluster is functioning correctly.

_`Mongodb` logs from `Docker` containers can be viewed in the shared folder [SHARE_WITH_ALL_DOCKER_CONTAINERS](./SHARE_WITH_ALL_DOCKER_CONTAINERS)_.

### :bookmark_tabs: Licence ###
MongoDB-Cluster-TLS is [CC BY-NC-SA 3.0 licensed](./LICENSE).
