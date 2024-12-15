# Описание docker-compose.yaml
---
В docker-compose.yaml собраны следующие образы:
1. СУБД PostgreSQL:13.3
2. СУБД ClickHouse:latest
3. Хранилище ZooKeeper:3.7
4. Брокер Kafka:latest
5. AWS Minio:latest (аналог S3)

---
Запуск:
```bash
docker compose -f docker-compose.yaml up -d
```

Проверка на запуск:
- ClickHouse: http://localhost:8123/
- Minio: http://localhost:9001/

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
