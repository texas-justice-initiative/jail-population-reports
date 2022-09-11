SELECT DISTINCT

    TO_DATE("0"::varchar(255), 'MM/DD/YYYY') AS data_date
    , processed_at
    , loaded_at
    , document_id
    , source_filename
FROM {{ source('tcjs_jail_population_report', 'jail_population') }}
WHERE "2" IS NULL
    AND "0" IS NOT NULL
    AND "0" NOT IN ('County', 'FELONS', 'Highlighted counties did not submit required reports.')
