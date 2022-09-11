SELECT
    "0" AS county_name
    , CASE WHEN "4" IS NOT NULL AND "3" IS NOT NULL THEN "2" ELSE "1" END AS inmate_count
    , CASE WHEN "4" IS NOT NULL AND "3" IS NOT NULL THEN "3" ELSE "2" END AS inmate_days
    , CASE WHEN "4" IS NOT NULL AND "3" IS NOT NULL THEN "4" ELSE coalesce("3", "4") END AS cost
    , CASE WHEN "1" = 'Total' THEN "4" END AS total_cost
    , processed_at
    , loaded_at
    , document_id
    , source_filename
FROM {{ source('tcjs_jail_population_report', 'immigrant_inmates') }}
