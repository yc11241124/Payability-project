SELECT
    max(createTime) as LastQuerydate, table_name, count(*) as cnt
FROM
    bq_audits.bq_query_audit_tables AS audit_tables
LEFT JOIN
    region-us.INFORMATION_SCHEMA.TABLES AS tables
ON tables.table_catalog= audit_tables.projectId AND tables.table_schema= audit_tables.datasetId AND tables.table_name= audit_tables.tableId
    AND CASE tables.table_type WHEN 'BASE TABLE' THEN audit_tables.table_type ='table' WHEN 'VIEW' THEN  audit_tables.table_type ='view' END
GROUP BY
    table_name
HAVING
    MAX(DATE(createTime)) <= CURRENT_DATE() - 90
ORDER BY 
    count(*) DESC
