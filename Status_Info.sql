SET PAGESIZE 1000;
SET LINESIZE 1000;

/*---  ---*/

SELECT source_name, 
    COUNT(rec_id)  AS rec_cnt 
FROM pds.enumTypeRef 
GROUP BY source_name; 

SELECT source_name, 
    COUNT(rec_id)  AS rec_cnt 
FROM prds_dev.enumTypeRef 
GROUP BY source_name; 

/*---  ---*/

SELECT enum_type, 
    COUNT(rec_id)  AS rec_cnt
FROM pds.enumValueRef  
GROUP BY enum_type 
ORDER BY UPPER(enum_type);

SELECT enum_type, 
    COUNT(rec_id)  AS rec_cnt
FROM prds_dev.enumValueRef  
GROUP BY enum_type 
ORDER BY UPPER(enum_type);

/*---  ---*/

SELECT etr.source_name, 
    COUNT(evr.rec_id)  AS rec_cnt
FROM pds.enumTypeRef etr
LEFT OUTER JOIN pds.enumValueRef evr ON evr.enum_type_rec_id = etr.rec_id 
GROUP BY etr.source_name 
ORDER BY etr.source_name; 

SELECT etr.source_name, 
    COUNT(evr.rec_id) AS rec_cnt 
FROM prds_dev.enumTypeRef etr
LEFT OUTER JOIN prds_dev.enumvalueref evr ON evr.enum_type_rec_id = etr.rec_id 
GROUP BY etr.source_name 
ORDER BY etr.source_name; 

/*---  ---*/

SELECT etr.source_name, etr.enum_type, COUNT(etr.rec_id) 
FROM pds.enumTypeRef etr
LEFT OUTER JOIN pds.enumValueRef evr ON evr.enum_type_rec_id = etr.rec_id 
-- WHERE etr.enum_type = 'OrganizationQualifierRoleType'
GROUP BY etr.source_name, etr.enum_type 
ORDER BY etr.source_name, etr.enum_type; 


/*----- Check to see if the table comment is present -----*/
/*

SELECT *  
FROM   user_tab_comments
ORDER BY table_name;

SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('%YourObjectName%'); 

*/

/*----- Check to see if the table column comments are present -----*/
/*
SELECT  b.column_id, 
        a.table_name, 
        a.column_name, 
        b.data_type, 
        b.data_length, 
        b.nullable, 
        b.data_default,  
        a.comments 
--        , '|', b.*  
FROM    user_col_comments a
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('%YourObjectName%') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('%YourObjectName%') 
ORDER BY b.column_id; 
*/


