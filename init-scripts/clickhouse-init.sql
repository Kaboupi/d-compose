/*
    Create readonly role and grant it to grafana user
*/

-- Readonly role
CREATE ROLE readonly;

-- Create default database

CREATE DATABASE IF NOT EXISTS default;

GRANT SELECT ON default.* TO readonly;

-- Grant role on Grafana user

CREATE USER grafana_user IDENTIFIED WITH plaintext_password BY 'grafana_password';

GRANT readonly TO grafana_user;
