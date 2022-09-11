SELECT DISTINCT

    dd.data_date
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
    , "17" AS total_capacity
    , "18" AS pct_capacity
    , "19" AS available_beds
    -- , TO_TIMESTAMP(src.loaded_at, 'YYYY-MM-DD HH24:MI:SS') AS loaded_at
    , TO_TIMESTAMP(src.processed_at, 'YYYY-MM-DD HH24:MI:SS') AS processed_at
    , src.document_id
    , src.source_filename
FROM {{ source('tcjs_jail_population_report', 'jail_population') }} AS src
LEFT JOIN {{ ref('jail_population_data_date') }} AS dd
    ON dd.processed_at = src.processed_at
        AND dd.loaded_at = src.loaded_at
        AND dd.document_id = src.document_id
WHERE
    (
        "1" IS NOT NULL OR "2" IS NOT NULL OR "3" IS NOT NULL OR "4" IS NOT NULL OR "5" IS NOT NULL
    ) AND "1" != 'Total' AND "0" != 'County' AND "1" NOT IN (
        'Felons', 'Pretrial', 'Violators', 'PAR. VIOLATORS', 'Parole'
    )
