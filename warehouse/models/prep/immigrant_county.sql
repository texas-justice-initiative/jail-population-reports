SELECT
    split_part("0", '(', 1) AS county_name
    , coalesce(split_part("0", '(', 2) = 'P)', FALSE) AS p_code
    , "1" AS inmate_count
    , "2" AS inmate_days
    , "3" AS cost
    , to_date(src.report_date::varchar(255), 'YYYYMM') AS report_date
    , to_timestamp(src.processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
    , dd.data_date
FROM {{ source('tcjs_jail_population_report', 'immigrant_inmates') }} AS src
LEFT JOIN {{ ref('immigrant_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
        AND dd.report_date = src.report_date
WHERE "0" != 'Immigration Detainer Report' AND "0" != 'COUNTY' AND "0" IS NOT NULL
