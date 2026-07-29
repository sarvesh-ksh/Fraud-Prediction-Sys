SELECT
    {{ dbt_utils.generate_surrogate_key([
        'step',
        'type',
        'nameOrig',
        'nameDest',
        'amount'
    ]) }} AS transaction_key,
    step,
    type              As payment_type,
    amount,
    nameOrig          AS sender_account,
    oldbalanceOrg     AS sender_old_balance,
    newbalanceOrig    AS sender_new_balance,
    nameDest          AS receiver_account,
    oldbalanceDest    AS receiver_old_balance,
    newbalanceDest    AS receiver_new_balance,
    isFraud           AS is_fraud,
    isFlaggedFraud    AS is_flagged_fraud
FROM {{ source('raw', 'PAYSIM_RAW') }}