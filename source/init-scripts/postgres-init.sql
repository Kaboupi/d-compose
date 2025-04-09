/*
    Create readonly role and grant it to grafana user
*/

-- ro_role
CREATE SCHEMA IF NOT EXISTS datamart;

CREATE ROLE ro_dqp;

GRANT CONNECT ON DATABASE postgres_db TO ro_dqp;

GRANT USAGE ON SCHEMA datamart TO ro_dqp;

GRANT SELECT ON ALL TABLES IN SCHEMA datamart TO ro_dqp;

ALTER DEFAULT PRIVILEGES IN SCHEMA datamart GRANT SELECT ON TABLES TO ro_dqp;

CREATE USER grafana_user WITH PASSWORD 'grafana_password';

GRANT ro_dqp TO grafana_user;
