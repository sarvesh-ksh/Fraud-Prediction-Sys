SELECT
    COUNT(*) AS total_rows,

    COUNT(CASE WHEN is_fraud = 1 THEN 1 END) AS fraud_transactions,

    COUNT(CASE WHEN is_fraud = 0 THEN 1 END) AS non_fraud_transactions,

    MIN(amount) AS min_transaction_amount,
    AVG(amount) AS avg_transaction_amount,
    MAX(amount) AS max_transaction_amount,
    COUNT(CASE WHEN amount IS NULL THEN 1 END) AS Amount_NC,
    COUNT(CASE WHEN payment_type IS NULL THEN 1 END) AS type_NC,
    COUNT(CASE WHEN is_fraud IS NULL THEN 1 END) AS fraud_NC,
    COUNT(CASE WHEN sender_account IS NULL THEN 1 END) AS sender_NC,
    COUNT(CASE WHEN receiver_account IS NULL THEN 1 END) AS receiver_NC
FROM 
    {{ ref('stg_paysim')}} 