SELECT
    INITCAP(SPLIT_PART(src.county_name, '(', 1)) AS county_name
    , COALESCE(SPLIT_PART(src.county_name, '(', 2) = 'P)', FALSE) AS p_code
    , src.inmate_count
    , src.inmate_days
    , src.cost::money
    , TO_TIMESTAMP(src.loaded_at, 'YYYY-MM-DD HH24:MI:SS') AS loaded_at
    , TO_TIMESTAMP(src.processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
    , dd.data_date
FROM {{ ref('immigrant_base') }} AS src
LEFT JOIN {{ ref('immigrant_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
        AND dd.loaded_at = src.loaded_at
        AND dd.document_id = src.document_id
WHERE
    src.county_name != 'Immigration Detainer Report' AND src.county_name != 'COUNTY' AND src.county_name IS NOT NULL
