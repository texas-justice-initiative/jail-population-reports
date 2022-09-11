SELECT
    TO_DATE("2"::varchar(255), 'MM/DD/YYYY') AS data_date
    , processed_at
    , loaded_at
    , document_id
    , source_filename
FROM {{ source('tcjs_jail_population_report', 'immigrant_inmates') }}
WHERE "0" = 'Immigration Detainer Report'
UNION DISTINCT
--some reports in 2015 had a distinct date column
SELECT DISTINCT

    TO_DATE("1"::varchar(255), 'MM/DD/YYYY') AS data_date
    , processed_at
    , loaded_at
    , document_id
    , source_filename
FROM {{ source('tcjs_jail_population_report', 'immigrant_inmates') }}
WHERE document_id IN (SELECT DISTINCT document_id FROM {{ source('tcjs_jail_population_report', 'immigrant_inmates') }}
    WHERE "1" = 'DATE') AND "1" != 'DATE' AND "1" != 'Total'
UNION DISTINCT
-- some reports between 2013-2015 has the date info one column over
SELECT
    TO_DATE("3"::varchar(255), 'MM/DD/YYYY') AS data_date
    , processed_at
    , loaded_at
    , document_id
    , source_filename
FROM {{ source('tcjs_jail_population_report', 'immigrant_inmates') }}
WHERE "1" = 'Immigration Detainer Report'
