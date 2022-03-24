SELECT max(createTime) as create_time, table_name
FROM bq_audits.bq_query_audit_tables AS audit_tables
LEFT JOIN
region-us.INFORMATION_SCHEMA.TABLES AS tables
ON tables.table_catalog= audit_tables.projectId AND tables.table_schema= audit_tables.datasetId AND tables.table_name= audit_tables.tableId
AND CASE tables.table_type WHEN 'BASE TABLE' THEN audit_tables.table_type ='table' WHEN 'VIEW' THEN  audit_tables.table_type ='view' END
WHERE NOTDATE(createTime) >= CURRENT_DATE() - 90
GROUP BY table_name