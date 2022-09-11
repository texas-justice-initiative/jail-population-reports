SELECT
    dd.data_date
    , SPLIT_PART(county_name, '(', 1) AS county_name
    , COALESCE(SPLIT_PART(county_name, '(', 2) = 'P)', FALSE) AS p_code
    , pregnant_female_count
    , TO_TIMESTAMP(src.processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
    , TO_TIMESTAMP(src.loaded_at, 'YYYY-MM-DD HH24:MI:SS') AS loaded_at
FROM {{ref('pregnancy_base')}} AS src
LEFT JOIN {{ ref('pregnancy_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
        AND dd.loaded_at = src.loaded_at
        AND dd.document_id = src.document_id
WHERE county_name NOT LIKE '%Total%'
