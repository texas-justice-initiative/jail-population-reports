SELECT
    TO_DATE(CONCAT(SPLIT_PART("8", ' ', 1), SPLIT_PART("8", ' ', 2)), 'Month YYYY') AS data_date
    , processed_at
    , document_id
FROM {{ source('tcjs_jail_population_report', 'serious_incidents') }}
WHERE "8" LIKE '%Serious Incident%'
