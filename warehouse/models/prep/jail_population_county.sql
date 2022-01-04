SELECT
    TO_DATE(report_date::varchar(255), 'YYYYMM') AS report_date
    , SPLIT_PART("0", '(', 1) AS county_name
    , COALESCE(SPLIT_PART("0", '(', 2) = 'P)', FALSE) AS p_code
    , "1" AS pretrial_felons
    , "2" AS convicted_felons
    , "3" AS convicted_felons_sentenced_county
    , "4" AS parole_violators
    , "5" AS parole_violators_new_charge
    , "6" AS pretrial_misdemeanor
    , "7" AS convicted_misdemeanor
    , "8" AS bench_warrants
    , "9" AS federal
    , "10" AS pretrial_sjf
    , "11" AS convicted_sjf_sentenced_county
    , "12" AS convicted_sjf_sentenced_state
    , "13" AS total_others
    , "14" AS total_local
    , "15" AS total_contract
    , "16" AS total_population
    , "17" AS total_capacit4
    , "18" AS pct_capacity
    , "19" AS available_beds
    , TO_TIMESTAMP(processed_at, 'YYYY-MM-DD HH:MI:SS') AS processed_at
FROM {{ source('tcjs_jail_population_report', 'jail_population') }}
WHERE
    (
        "1" IS NOT NULL OR "2" IS NOT NULL OR "3" IS NOT NULL OR "4" IS NOT NULL OR "5" IS NOT NULL
    ) AND "1" != 'Total'
