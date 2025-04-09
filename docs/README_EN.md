![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![ClickHouse](https://img.shields.io/badge/ClickHouse-FFCC01?style=for-the-badge&logo=clickhouse&logoColor=white)
![Apache](https://img.shields.io/badge/apache-%23D42029.svg?style=for-the-badge&logo=apache&logoColor=white)
![Grafana](https://img.shields.io/badge/grafana-%23F46800.svg?style=for-the-badge&logo=grafana&logoColor=white)


# D-compose 🐳

A stack of services for practicing Data Engineering.

The project is configured for a comfortable and quick launch of all services with a single *docker compose* command.

[**docker-compose.yaml**](https://github.com/Kaboupi/d-compose/blob/master/docker-compose.yaml) includes following images:

|Number|Docker Image|Image TAG|Description|TAG when added|
|---|---|---|---|
|1|PostgreSQL|postgres:13.3|OLTP DB|
|2|ClickHouse|clickhouse/clickhouse-server:latest|OLAP DB|
|3|Apache Airflow|apache/airflow:2.10.4|ETL|
|4|Apache Kafka|confluentinc/cp-kafka:latest|Message Broker|
|5|Apache Zookeeper|zookeeper:3.7|Coordination/Management|
|6|Apache Nifi|apache/nifi:1.28.1|ETL|
|7|Minio|minio/minio:latest|Object Storage|
|8|Grafana Enterprise|grafana/grafana-enterprise:latest|BI Tool|

<!--Установка-->

## Installation (Windows / Linux)

**Linux**:

To run the containers on Linux, **Docker Compose** and all necessary dependencies must be met. Full installation documentation is available in the [official documentation](https://docs.docker.com/compose/install/linux/). You can also install the [Docker Desktop version for Linux](https://docs.docker.com/desktop/).

**Windows**:
To install **Docker Compose**, you need to install the [Docker Desktop version for Windows](https://docs.docker.com/desktop/) and have WSL installed.

You can find the installation and setup guide for WSL on the [official Microsoft website](https://learn.microsoft.com/ru-ru/windows/wsl/install).

1. Clone the repo

```bash
git clone git@github.com:Kaboupi/d-compose.git
```

2. Navigate to the d-compose directory

```bash
cd d-compose
```

3. Start the Docker containers

```bash
docker compose up -d
```

4. Verify the functionality of the main services

- **Clickhouse**: [http://localhost:8123/](http://localhost:8123/)
- **Airflow**: [http://localhost:8080/](http://localhost:8080/)
- **Minio**: [http://localhost:9001/](http://localhost:9001/)
- **Grafana**: [http://localhost:3000/](http://localhost:3000/)
- - In **Data Sources**, there should be connections to the Postgres DB and Clickhouse DB. Configurations are stored in `sources/grafana/provisioning/datasources/datasources.yaml`.

Healthcheck is included for both databases, and by default, PVs exist only for Grafana connections.

> ❗If you want to add PVs, you need to specify them directly in `volumes:`, for example:
>
> ```yaml
> services:
>   clickhouse:
>     image: clickhouse/clickhouse-server:latest
>     ...
>     volumes:
>       - my_custom_volume:/var/lib/clickhouse  # docker volume
>       - ./my_custom_dir:/var/lib/clickhouse   # bind mount
>
> volumes:
>   my_custom_volume:
> ```

Connection credentials are listed in [.env](https://github.com/Kaboupi/d-compose/blob/master/.env) file

<!--Документация-->

## Documentation

The documentation for the services is located in the `docs` directory

You can view its table of contents by following this link - [__Docs__](https://github.com/Kaboupi/d-compose/blob/master/docs/list.md)

<!--Support-->

## Support

If you encounter any difficulties or have questions about using the package, create a [discussion](https://github.com/kaboupi/d-compose/issues/new/choose) in this repository.

<!--Зависимости-->

## Dependencies

Linux:

- Docker compose release ~>2.28.0 or latest

Windows:

- Windows 10 ~>22H2
- WSL (preferably 2.0)
- Docker Desktop ~>4.20 or latest
