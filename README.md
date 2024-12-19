# Описание docker-compose.yaml
---
В docker-compose.yaml собраны следующие образы:
1. СУБД PostgreSQL:13.3
2. СУБД ClickHouse:latest
3. Хранилище ZooKeeper:3.7
4. Брокер Kafka:latest (Закомменчен)
5. AWS Minio:latest (аналог S3)
6. Grafaba Enterprise (BI-инструмент для визуализации)

---
Запуск:
1. cd в директорию проекта
2. Поднимаем образы через compose
```bash
docker compose up -d
```
3. После первичного запуска необходимо сделать рестарт, чтобы ClickHouse подцепил конфиги из `kaboupi_clickhouse/`:
```bash
docker compose restart
```
4. Радуемся поднятым сервисам!

> ❗Если хотите добавить PV, то нужно прописать их напрямую в `volumes:`, например:
> ```yaml
> services:
>   clickhouse:
>     image: clickhouse/clickhouse-server:latest
>     ...
>     volumes:
>       - ./kaboupi_clickhouse:/etc/clickhouse-server
>       - ./my_custom_dir:/var/lib/clickhouse  # эта строчка добавит в вашу локальную! директорию my_custom_dir все данные клика
> 
> volumes:
>   kaboupi_clickhouse:
>     driver: local
>   my_custom_dir:
>     driver: local
> ```

Проверка на запуск:
- ClickHouse: http://localhost:8123/
- Minio: http://localhost:9001/
- Grafana: http://localhost:3000/

Креды для подключения:
- Postgres
- - host: localhost
  - port: 5432
  - username: kaboupi
  - password: kaboupi
- ClickHouse
- - host: localhost
  - port: 8123
  - username: admin
  - password: kaboupi

Ориентировочное потребление ресурсов:
- `docker.raw` + 6Гб
- RAM ~2-5Гб
- Диск ~50-100Мб
