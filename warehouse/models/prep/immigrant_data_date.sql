SELECT
    TO_DATE("2"::varchar(255), 'MM/DD/YYYY') AS data_date
    , processed_at
    , report_date
FROM {{ source('tcjs_jail_population_report', 'immigrant_inmates') }}
WHERE "0" = 'Immigration Detainer Report'
