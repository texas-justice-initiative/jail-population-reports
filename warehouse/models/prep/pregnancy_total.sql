SELECT
    TO_DATE(report_date::varchar(255), 'YYYYMM') AS report_date
    , pregnant_female_count
    , TO_TIMESTAMP(processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
FROM {{ref('pregnancy_base')}}
WHERE county_name LIKE '%Total%'
