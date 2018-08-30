SET PAGESIZE 1000;
SET LINESIZE 1000;

SELECT at.owner, 
    at.table_name, 
    at.num_rows, 
    at.avg_row_len, 
    atc.comments, 
    at.tablespace_name 
FROM all_tables at
LEFT OUTER JOIN all_tab_comments atc ON at.table_name = atc.table_name 
WHERE at.owner = 'PDS'  
ORDER BY at.owner, 
    at.table_name, 
   at. tablespace_name;
   
   
SELECT atc.owner,
    atc.table_name, 
    atc.column_name, 
    atc.column_id AS "Ordinal", 
    atc.data_type, 
    atc.data_length, 
    atc.data_precision,
    atc.num_nulls, 
    acc.comments, 
    atc.data_default, 
    atc.low_value,
    atc.high_value  
--    , atc.* 
FROM all_tab_cols atc 
LEFT OUTER JOIN all_col_comments acc ON atc.table_name = acc.table_name
    AND atc.column_name = acc.column_name 
WHERE atc.owner = 'PDS' 
--    AND atc.table_name = '' 
ORDER BY atc.owner, 
    atc.table_name,
    atc.column_id;   
    
SELECT DISTINCT enum_type, 
    COUNT(rec_id) AS "Rec Cnt"
FROM enum_value_ref 
GROUP BY enum_type
ORDER BY enum_type; 
    
/*--  --*/

SELECT at.* 
FROM all_tables at  
ORDER BY at.owner, 
    at.table_name, 
    at.tablespace_name; 
    

SELECT atc.* 
FROM all_tab_comments atc 
ORDER BY atc.owner, 
    atc.table_name; 

    
SELECT atc.* 
FROM all_tab_cols atc 
WHERE atc.owner = 'PDS' 
--    AND atc.table_name = '' 
ORDER BY atc.owner, 
    atc.table_name,
    atc.column_id;  
    
    
SELECT acc.* 
FROM all_col_comments acc
WHERE acc.owner = 'PDS' ; 

