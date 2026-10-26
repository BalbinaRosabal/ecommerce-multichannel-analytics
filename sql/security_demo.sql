-- OPTIONAL DEMONSTRATION ONLY: RUN IN A THROWAWAY LOCAL MYSQL INSTANCE.
-- This script DROPS and recreates named users/roles; do not run against shared systems.
-- Edit both password placeholders locally before executing; never commit your replacements.
USE ecommerce_analytics;

-- ============================================================
-- 7. ROLE-BASED ACCESS CONTROL
-- ============================================================

-- Remove existing project users and roles if they already exist.
DROP USER IF EXISTS
    'analyst_user'@'localhost',
    'etl_user'@'localhost';

DROP ROLE IF EXISTS
    'analyst_role',
    'etl_role';

-- Create least-privilege roles.
CREATE ROLE 'analyst_role', 'etl_role';

-- Analyst has read-only access to the ecommerce_analytics database.
GRANT SELECT ON ecommerce_analytics.* TO 'analyst_role';

-- ETL role can manipulate project data but is not granted
-- structural/server administration privileges.

GRANT SELECT, INSERT, UPDATE, DELETE
ON ecommerce_analytics.* TO 'etl_role';

-- Create users with placeholder passwords and assign their roles.
CREATE USER 'analyst_user'@'localhost'
IDENTIFIED BY 'REPLACE_WITH_STRONG_LOCAL_SECRET';

CREATE USER 'etl_user'@'localhost'
IDENTIFIED BY 'REPLACE_WITH_STRONG_LOCAL_SECRET';

GRANT 'analyst_role'
TO 'analyst_user'@'localhost';

GRANT 'etl_role'
TO 'etl_user'@'localhost';

SET DEFAULT ROLE 'analyst_role'
TO 'analyst_user'@'localhost';

SET DEFAULT ROLE 'etl_role'
TO 'etl_user'@'localhost';

SHOW GRANTS FOR 'analyst_role';
SHOW GRANTS FOR 'etl_role';
SHOW GRANTS FOR 'analyst_user'@'localhost';
SHOW GRANTS FOR 'etl_user'@'localhost';

-- ============================================================
-- END OF SCRIPT
-- ============================================================
