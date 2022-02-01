SELECT
    split_part("0", '(', 1) AS county_name
    , coalesce(split_part("0", '(', 2) = 'P)', FALSE) AS p_code
    , CASE WHEN "1"::numeric IS NULL THEN "2"::numeric ELSE "1"::numeric END AS suicide_count
    , CASE
        WHEN "3"::numeric IS NULL THEN "4"::numeric ELSE "2"::numeric
    END AS attempted_suicide_count
    , CASE
        WHEN "5"::numeric IS NULL THEN "6"::numeric ELSE "3"::numeric
    END AS death_in_custody_count
    , CASE WHEN "7"::numeric IS NULL THEN "8"::numeric ELSE "4"::numeric END AS escape_count
    , CASE
        WHEN "9"::numeric IS NULL AND "10"::numeric IS NOT NULL THEN "10"::numeric ELSE "5"::numeric
    END AS assault_count
    , CASE
        WHEN
            "11"::numeric IS NULL AND "12"::numeric IS NOT NULL THEN "12"::numeric
        ELSE "6"::numeric
    END AS sexual_assault_count
    , CASE
        WHEN "13"::numeric IS NOT NULL THEN "13"::numeric ELSE "7"::numeric
    END AS serious_injury_count
    , CASE
        WHEN
            "14"::numeric IS NULL AND "15"::numeric IS NOT NULL THEN "15"::numeric
        ELSE "8"::numeric
    END AS use_of_force_count
    , to_timestamp(src.processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
    , dd.data_date
FROM {{ source('tcjs_jail_population_report', 'serious_incidents') }} AS src
LEFT JOIN {{ ref('serious_incidents_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
        AND dd.document_id = src.document_id
WHERE
    "0" IS NOT NULL AND "14" IS NULL
    AND "0" NOT LIKE 'Totals'
