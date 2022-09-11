SELECT DISTINCT

    dd.data_date
    , "2" AS pretrial_felons
    , "3" AS convicted_felons
    , "4" AS convicted_felons_sentenced_county
    , "5" AS parole_violators
    , "6" AS parole_violators_new_charge
    , "7" AS pretrial_misdemeanor
    , "8" AS convicted_misdemeanor
    , "9" AS bench_warrants
    , "10" AS federal
    , "11" AS pretrial_sjf
    , "12" AS convicted_sjf_sentenced_county
    , "13" AS convicted_sjf_sentenced_state
    , "14" AS total_others
    , "15" AS total_local
    , "16" AS total_contract
    , "17" AS total_population
    , "18" AS total_capacity
    , "19" AS pct_capacity
    , "20" AS available_beds
    -- , TO_TIMESTAMP(src.loaded_at, 'YYYY-MM-DD HH24:MI:SS') AS loaded_at
    , TO_TIMESTAMP(src.processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
FROM {{ source('tcjs_jail_population_report', 'jail_population') }} AS src
LEFT JOIN {{ ref('jail_population_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
        AND dd.loaded_at = src.loaded_at
        AND dd.document_id = src.document_id
WHERE "1" = 'Total'
