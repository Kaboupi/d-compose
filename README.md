# d-compose

### Документация по сервисам

- [Документация](https://github.com/Kaboupi/d-compose/blob/master/docs/list.md)

### Описание репозитория

Репозиторий представляет собой стартовый набор сервисов для практики в области инженерии данных: СУБД, BI, брокеры, Object Storage.
Проект настроен на комфортный запуск всех сервисов одной командой, по дефолту прописаны PV для сохранения дашбордов графаны и данных Postgres.

В **docker-compose.yaml** собраны следующие образы:
1. PostgreSQL:13.3
2. ClickHouse:latest
3. ZooKeeper:3.7
4. Kafka:latest (Закомменчен)
5. Minio:latest (аналог S3)
6. Grafana Enterprise (BI-инструмент для визуализации)

Для обеих СУБД присутствует healthcheck

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

### Процедура запуска
1. Переходим в директорию проекта
Если открыли в VSCode, то просто открываем `<Ctrl+J>`, если же из терминала (cmd/pwsh/terminal), то
```bash
cd /this/project/parent/folder
git clone <this-project-url>
cd d-compose
```
2. Пуллим образы и поднимаем контейнеры
```bash
docker compose up -d
```
3. После первичного запуска необходимо сделать рестарт сервиса `clickhouse-server`, чтобы он подцепил конфиги пользователей и основных настроек из `kaboupi_clickhouse/*.xml`:
```bash
docker restart kaboupi-clickhouse
```
4. Проверка на запуск
- **Clickhouse**: [http://localhost:8123/](http://localhost:8123/)
- **Minio**: [http://localhost:9001/](http://localhost:9001/)
- **Grafana**: [http://localhost:3000/](http://localhost:3000/)

5. Радуемся поднятым сервисам! :)