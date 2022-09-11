SELECT
    CASE WHEN src.inmate_count = 'Total' THEN src.inmate_days
              ELSE src.inmate_count END AS inmate_count
    , CASE WHEN src.inmate_count = 'Total' THEN src.cost
                ELSE src.inmate_days END AS inmate_days
    , src.cost::money
    , TO_TIMESTAMP(src.loaded_at, 'YYYY-MM-DD HH24:MI:SS') AS loaded_at
    , TO_TIMESTAMP(src.processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
    , dd.data_date
FROM {{ ref('immigrant_base') }} AS src
FULL OUTER JOIN {{ ref('immigrant_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
        AND dd.loaded_at = src.loaded_at
        AND dd.document_id = src.document_id
WHERE (src.county_name IS NULL OR src.county_name LIKE '%otal%' OR src.inmate_count LIKE '%otal%')
    AND src.inmate_count IS NOT NULL AND src.inmate_count != 'Immigration Detainer Report'
