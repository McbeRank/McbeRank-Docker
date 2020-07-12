# McbeRank Docker image
Welcome to McbeRank-Docker. This is an docker image which is integration of `McbeRank` and `McbeRank-Vue`.

<br>

# Installation Guide

## 1. Set up database
First of all, those database are **required** to run McbeRank.

<br>

### 1-1. MongoDB
MongoDB is used for server data collection. Also keep these data up to latest
```bash
# We will work on home directory. You can change the directory if you want.
$ cd ~
$ mkdir -p mongodb/db
$ cd mongodb
$ docker run -dit
	--name mongodb \
	-p 27017:27017 \
	--restart unless-stopped \
	-e MONGO_INITDB_ROOT_USERNAME=admin \
	-e MONGO_INITDB_ROOT_PASSWORD=YOUR_SECRET_PASSWORD \
	-v $PWD/db:/data/db \
	mongo
```

<br>

### 1-2. InfluxDB
InfluxDB is used for statistics collection.
```bash
# We will work on home directory. You can change the directory if you want.
$ cd ~
$ mkdir -p influxdb/db
$ cd influxdb
$ docker run -dit \
	--name influxdb \
	-p 8086:8086 \
	--restart unless-stopped \
	-e INFLUXDB_ADMIN_USER=admin \
	-e INFLUXDB_ADMIN_PASSWORD=YOUR_SECRET_PASSWORD \
	-v $PWD/db:/var/lib/influxdb \
	influxdb
```

<br>

## 2. Running your McbeRank container
> **NOTE:** If you are going to use whitelist ports using `-p <PORT>:<PORT>`, `McbeRank` cannot reach to database because `localhost` points container itself. So you should configure database host to machine's real ip address.
```bash
$ cd ~
$ mkdir -p mcberank/logs
$ cd mcberank
$ docker run -d \
    --name mcberank \
    --restart unless-stopped \
    --net host \
    -v $PWD/logs:/usr/src/app/logs \
    -e MCBERANK_SERVER_PORT=80 \
    -e MCBERANK_MONGODB_USERNAME=admin \
    -e MCBERANK_MONGODB_PASSWORD=YOUR_SECRET_PASSWORD \
    -e MCBERANK_INFLUXDB_USERNAME=admin \
    -e MCBERANK_INFLUXDB_PASSWORD=YOUR_SECRET_PASSWORD \
    mcberank/mcberank:latest
```

<br>

# Configuration
All of `config.ini` variables can be overridden using environment variables using the syntax:
```bash
MCBERANK_<SectionName>_<KeyName>
```

You can define environment variables with `-e` option.
```bash
$ docker run -d \
    --name mcberank \
    --net host \
    -e MCBERANK_SERVER_PORT=80 \
    -e MCBERANK_SUBDOMAIN_ENABLE=true \
    mcberank/mcberank:latest
```

<br>

# Work with source code

## Download Source
You should add `--recursive` to download all submodules.
```bash
$ git clone --recursive https://github.com/McbeRank/McbeRank-Docker
```

You can get folder structure as shown below:
```bash
McbeRank-Docker
 ├── McbeRank      # Backend: Express API server
 ├── McbeRank-Vue  # Frontend: Vue.js template files
 └── Dockerfile
```

<br>

## Build your custom docker image
```bash
$ docker build -t <your name>/mcberank .
```

