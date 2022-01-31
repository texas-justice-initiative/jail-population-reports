SELECT
    "1"::numeric AS suicide_count
    , "2"::numeric AS attempted_suicide_count
    , "3"::numeric AS death_in_custody_count
    , "4"::numeric AS escape_count
    , "5"::numeric AS assault_count
    , "6"::numeric AS sexual_assault_count
    , "7"::numeric AS serious_injury_count
    , "8"::numeric AS use_of_force_count
    , to_timestamp(src.processed_at, 'YYYY-MM-DD HH:MI:SS') AS processed_at
    , dd.data_date
FROM {{ source('tcjs_jail_population_report', 'serious_incidents') }} AS src
LEFT JOIN {{ ref('serious_incidents_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
        AND dd.report_date = src.report_date
WHERE
    "0" = 'Totals'
