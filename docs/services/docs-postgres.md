# Postgres

Дефолтные параметры подключения

- DBeaver / Other IDE
- - **Host**: localhost
- - **Port**: 5432
- - **Login**: postgres_user
- - **Password**: postgres_password
- Services (Grafana, Airflow, etc.)
- - **Host: db-postgres**
- - **Port**: 5432
- - **Login**: postgres_user (grafana_user:ro for datamart schema, see postgres-init.sql)
- - **Password**: postgres_password (grafana_password:ro for datamart schema, see postgres-init.sql)
