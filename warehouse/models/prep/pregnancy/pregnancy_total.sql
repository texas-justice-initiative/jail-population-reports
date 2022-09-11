SELECT
    dd.data_date
    , pregnant_female_count
    , TO_TIMESTAMP(src.processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
    , TO_TIMESTAMP(src.loaded_at, 'YYYY-MM-DD HH24:MI:SS') AS loaded_at
FROM {{ref('pregnancy_base')}} AS src
FULL OUTER JOIN {{ ref('pregnancy_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
        AND dd.loaded_at = src.loaded_at
        AND dd.document_id = src.document_id
WHERE county_name LIKE '%Total%'
