![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![ClickHouse](https://img.shields.io/badge/ClickHouse-FFCC01?style=for-the-badge&logo=clickhouse&logoColor=white)
![Apache](https://img.shields.io/badge/apache-%23D42029.svg?style=for-the-badge&logo=apache&logoColor=white)
![Grafana](https://img.shields.io/badge/grafana-%23F46800.svg?style=for-the-badge&logo=grafana&logoColor=white)


# D-compose 🐳

A stack of services for practicing Data Engineering / DevOps / DBA.

The project is configured for a comfortable and quick launch of all services with a single *docker compose* command.

[**docker-compose.yaml**](https://github.com/Kaboupi/d-compose/blob/master/docker-compose.yaml) includes following images:

|Number|Docker Image|Image TAG|Description|TAG when added|
|---|---|---|---|---|
|1|PostgreSQL|13.3|OLTP DB|v1.0.0|
|2|ClickHouse|latest|OLAP DB|v1.0.0|
|3|Apache Airflow|2.10.4|ETL|v1.0.0|
|4|Apache Kafka|latest|Message Broker|v1.0.0|
|5|Apache Zookeeper|3.7|Coordination/Management|v1.0.0|
|6|Minio|latest|Object Storage|v1.0.0|
|7|Grafana Enterprise|latest|BI Tool|v1.0.0|

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

3. Initialize Airflow metadata

```bash
docker compose up airflow-init
```

Wait for the completion message `kaboupi-af-init exited with code 0`

4. Start the Docker containers

```bash
docker compose up -d
```

5. Restart the `kaboupi-clickhouse` service

After the initial startup, you need to restart the `clickhouse` service so that it can pick up the user configurations and main settings from `kaboupi_clickhouse/*.xml`:

```bash
docker restart kaboupi-clickhouse
```

6. Verify the functionality of the main services

- **Clickhouse**: [http://localhost:8123/](http://localhost:8123/)
- **Airflow**: [http://localhost:8080/](http://localhost:8080/)
- **Minio**: [http://localhost:9001/](http://localhost:9001/)
- **Grafana**: [http://localhost:3000/](http://localhost:3000/)
- - In **Data Sources**, there should be connections to the Postgres DB (kaboupi-postgres) and Clickhouse DB (kaboupi-clickhouse). Configurations are stored in `kaboupi_grafana-provisioning/datasources/datasources.yaml`.

Healthcheck is included for both databases, and by default, PVs exist only for Grafana connections.

> ❗If you want to add PVs, you need to specify them directly in `volumes:`, for example:
>
> ```yaml
> services:
>   clickhouse:
>     image: clickhouse/clickhouse-server:latest
>     ...
>     volumes:
>       - ./kaboupi_clickhouse:/etc/clickhouse-server
>       - ./my_custom_dir:/var/lib/clickhouse  # This line will add all click data to your local directory my_custom_dir
>
> volumes:
>   kaboupi_clickhouse:
>     driver: local
>   my_custom_dir:
>     driver: local
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
