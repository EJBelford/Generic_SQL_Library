SET PAGESIZE 1000;
SET LINESIZE 1000;

SELECT etr.appl_name, 
    evr.enum_type, 
    evr.enum_value,
    SUBSTR(evr.description, 1, 80) AS "Desc (80 chars)",
    evr.status
FROM pds.ENUM_VALUE_REF evr 
LEFT OUTER JOIN pds.ENUM_TYPE_REF etr ON  etr.enum_type = evr.enum_type
WHERE etr.appl_name = 'ProcurementDocument'
--WHERE UPPER(evr.enum_value) LIKE UPPER('%acc%') 
--WHERE UPPER(evr.enum_value) IN ( UPPER('acceptance'), 
--    UPPER('20FootContainer'), 
--    UPPER('20Pack') ) 
ORDER BY evr.enum_type, evr.enum_value;


/*--- PDS_Enum_Values ---*/

SELECT SUBSTR(evr.description, 1, 80) AS "Lookup_Value", 
    evr.enum_type AS "Enum_Type", 
    evr.enum_value AS "Enum_Value",
    etr.appl_name AS "Appl_Name" -- ,
--    SUBSTR(evr.description, 1, 80) AS "Desc (80 chars)",
--    evr.status
FROM pds.ENUM_VALUE_REF evr 
LEFT OUTER JOIN pds.ENUM_TYPE_REF etr ON  etr.enum_type = evr.enum_type
WHERE etr.appl_name = 'ProcurementDocument'
ORDER BY evr.enum_type, evr.enum_value;

