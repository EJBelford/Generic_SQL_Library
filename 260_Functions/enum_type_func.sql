/*---  ---*/


/*--- Generate a list of (ADS) from Enum Type 'ads_source' ---*/

SELECT DISTINCT evr.enum_Value, 
    evr.order_By, 
    evr.enum_Display_Name,
    evr.description 
--    , '|', etr.* 
FROM EnumTypeRef etr
LEFT OUTER JOIN EnumValueRef evr ON etr.ads_Id = evr.enum_Type_Rec_Id 
WHERE UPPER(etr.enum_Type) = UPPER('ads_source')
GROUP BY evr.enum_Value, evr.enum_Display_Name, evr.description, evr.order_By  
ORDER BY evr.order_By, evr.enum_Value;


SELECT DISTINCT etr.enum_Type,
    evr.enum_Value,
    evar.enum_Assoc_Code, 
    evr.order_By, 
    evr.enum_Display_Name,
    evr.description
--    , '|', etr.* 
FROM EnumTypeRef etr
LEFT OUTER JOIN EnumValueRef evr ON etr.ads_Id = evr.enum_Type_Rec_Id 
LEFT OUTER JOIN EnumValueAssocRef evar ON evr.rec_Id = evar.enum_Value_Rec_Id 
WHERE UPPER(etr.enum_Type) = UPPER('ads_source')
GROUP BY evar.enum_Assoc_Code, etr.enum_Type, evr.enum_Value, 
    evr.enum_Display_Name, evr.description, evr.order_By  
ORDER BY evr.enum_Value DESC, evar.enum_Assoc_Code DESC, evr.order_By;


/*--- Generate a distinct list of source_names from the Enum Type ---*/

SELECT DISTINCT etr.source_name,  
    etr.source_version, 
    COUNT(etr.enum_Type) AS cnt_type
--    , '|', etr.* 
FROM EnumTypeRef etr
GROUP BY etr.source_name, etr.source_version 
ORDER BY etr.source_name, etr.source_version;


/*--- Generation list of Enum Types for list box ---*/

SELECT etr.rec_Id, 
    etr.enum_Type, 
    COUNT(evr.enum_Type) AS cnt_value,  
    etr.enum_Type_Desc, 
    etr.source_name, 
    etr.source_version, 
    etr.classification,
    etr.constant_flag
--    , '|', etr.* 
FROM EnumTypeRef etr
LEFT OUTER JOIN EnumValueRef evr ON etr.rec_Id = evr.enum_Type_Rec_Id 
GROUP BY etr.enum_Type, etr.rec_Id, etr.enum_Type_Desc, etr.classification, 
    etr.constant_flag, etr.source_name, etr.source_version 
ORDER BY etr.enum_Type;


/*---  ---*/

SELECT evar.* 
FROM enumValueAssocRef evar 
ORDER BY evar.enum_Type, evar.enum_Value, evar.enum_Assoc_Type;

