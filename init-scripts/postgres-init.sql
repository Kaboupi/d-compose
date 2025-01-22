/*
    Create readonly role and grant it to grafana user
*/

-- Readonly role
CREATE ROLE readonly;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;

-- Grant role on Grafana user

CREATE USER grafana_user WITH PASSWORD 'grafana_password';

GRANT readonly TO grafana_user;
