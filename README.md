# D-compose 🐳
Стэк из сервисов для практики в области Data Engineering / DevOps.

Проект настроен на комфортный и быстрый запуск всех сервисов одной командой.

В [**docker-compose.yaml**](https://github.com/Kaboupi/d-compose/blob/master/docker-compose.yaml) собраны следующие образы:
1. PostgreSQL:13.3
2. ClickHouse:latest
3. ZooKeeper:3.7
4. Kafka:latest (Закомменчен)
5. Minio:latest (аналог S3)
6. Grafana Enterprise:latest

<!--Установка-->
## Установка (Windows / Linux)

**Linux**:

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) 

Для поднятия контейнеров на Linux должны быть установлены **Docker compose** и все необходимые зависимости. Полная документация по установке указана в [официальной документации](https://docs.docker.com/compose/install/linux/). Также можно установить [Desktop версию](https://docs.docker.com/desktop/)

**Windows**:
Для установки **Docker compose** необходимо установить [Desktop версию для Windows](https://docs.docker.com/desktop/) и иметь установленную WSL 2.0.

Ознакомиться с гайдом по установке и настройке WSL можно на [официальном сайте Microsoft](https://learn.microsoft.com/ru-ru/windows/wsl/install).

1. Клонирование репозитория

```bash
git clone git@github.com:Kaboupi/d-compose.git
```

2. Переход в директорию D-compose

```absh
cd d-compose
```

3. Поднятие Docker контейнеров

```bash
docker compose up -d
```

4. Рестарт сервиса `kaboupi-clickhouse`

После первичного запуска необходимо сделать рестарт сервиса `clickhouse`, чтобы он подцепил конфиги пользователей и основных настроек из `kaboupi_clickhouse/*.xml`:

```bash
docker restart kaboupi-clickhouse
```

5. Провести проверку работоспособности основных сервисов

- **Clickhouse**: [http://localhost:8123/](http://localhost:8123/)
- **Minio**: [http://localhost:9001/](http://localhost:9001/)
- **Grafana**: [http://localhost:3000/](http://localhost:3000/)
- - В **Data Sources** должны присутствовать подключения к СУБД Postgres (kaboupi-postgres) и СУБД Clickhouse (kaboupi-clickhouse). Конфигурации хранятся в `kaboupi_grafana-provisioning/datasources/datasources.yaml`

Для обеих СУБД присутствует healthcheck, по дефолту PV прописаны только для сохранения подключений к Grafana.

> ❗Если хотите добавить PV, то нужно прописать их напрямую в `volumes:`, например:
> ```yaml
> services:
>   clickhouse:
>     image: clickhouse/clickhouse-server:latest
>     ...
>     volumes:
>       - ./kaboupi_clickhouse:/etc/clickhouse-server
>       - ./my_custom_dir:/var/lib/clickhouse  # эта строчка добавит в вашу локальную директорию my_custom_dir все данные клика
> 
> volumes:
>   kaboupi_clickhouse:
>     driver: local
>   my_custom_dir:
>     driver: local
> ```

<!--Документация-->
## Документация

Документация по сервисам находится в директории docs

Ознакомиться с её оглавлением можно по ссылке - [Документация d-compose](https://github.com/Kaboupi/d-compose/blob/master/docs/list.md)

<!--Support-->
## Поддержка

Если у вас возникли сложности или вопросы по использованию пакета, создайте 
[обсуждение](https://github.com/kaboupi/d-compose/issues/new/choose) в данном репозитории.

<!--Зависимости-->
## Зависимости

Linux:
- Docker compose release ~>2.28.0 or latest
Windows:
- Windows 10 ~>22H2
- WSL (желательно 2.0)
- Docker Desktop ~>4.20 or latest
