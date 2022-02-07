SELECT
    TO_DATE(report_date::varchar(255), 'YYYYMM') AS report_date
    , SPLIT_PART(county_name, '(', 1) AS county_name
    , COALESCE(SPLIT_PART(county_name, '(', 2) = 'P)', FALSE) AS p_code
    , pregnant_female_count
    , TO_TIMESTAMP(processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
FROM {{ref('pregnancy_base')}}
WHERE county_name NOT LIKE '%Total%'
