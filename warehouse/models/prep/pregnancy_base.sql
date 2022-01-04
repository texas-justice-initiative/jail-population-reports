SELECT
    "0" AS county_name
    , "1"::text AS pregnant_female_count
    , processed_at
    , report_date
FROM {{ source('tcjs_jail_population_report', 'pregnant_inmates') }}
WHERE "0" IS NOT NULL
UNION DISTINCT
SELECT
    "2" AS county_name
    , "3"::text AS pregnant_female_count
    , processed_at
    , report_date
FROM {{ source('tcjs_jail_population_report', 'pregnant_inmates') }}
WHERE "2" IS NOT NULL
UNION DISTINCT
SELECT
    "4" AS county_name
    , "5"::text AS pregnant_female_count
    , processed_at
    , report_date
FROM {{ source('tcjs_jail_population_report', 'pregnant_inmates') }}
WHERE "4" IS NOT NULL
UNION DISTINCT
SELECT
    "6" AS county_name
    , "7"::text AS pregnant_female_count
    , processed_at
    , report_date
FROM {{ source('tcjs_jail_population_report', 'pregnant_inmates') }}
WHERE "6" IS NOT NULL
UNION DISTINCT
SELECT
    "8" AS county_name
    , "9"::text AS pregnant_female_count
    , processed_at
    , report_date
FROM {{ source('tcjs_jail_population_report', 'pregnant_inmates') }}
WHERE "8" IS NOT NULL
