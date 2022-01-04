SELECT
    "1" AS inmate_count
    , "2" AS inmate_days
    , "3" AS cost
    , TO_DATE(src.report_date::varchar(255), 'YYYYMM') AS report_date
    , TO_TIMESTAMP(src.processed_at, 'YYYY-MM-DD HH:MI:SS') AS processed_at
    , dd.data_date
FROM {{ source('tcjs_jail_population_report', 'immigrant_inmates') }} AS src
LEFT JOIN {{ ref('immigrant_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
       AND dd.report_date = src.report_date
WHERE "0" IS NULL AND "1" IS NOT NULL
