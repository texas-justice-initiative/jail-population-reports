SELECT
    "2" AS data_date
    , processed_at
    , report_date
FROM {{ source('tcjs_jail_population_report', 'immigrant_inmates') }}
WHERE "0" = 'Immigration Detainer Report'
