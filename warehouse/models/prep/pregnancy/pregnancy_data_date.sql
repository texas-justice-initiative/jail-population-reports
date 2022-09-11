SELECT
    TO_DATE(SPLIT_PART("1", ' ', 9), 'MM/DD/YYYY') AS data_date
    , processed_at
    , loaded_at
    , document_id
    , source_filename
FROM {{ source('tcjs_jail_population_report', 'pregnant_inmates') }}
WHERE "1" LIKE '%Pregnant Females%'
