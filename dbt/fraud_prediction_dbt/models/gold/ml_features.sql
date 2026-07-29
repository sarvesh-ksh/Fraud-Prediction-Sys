WITH sender_activity AS (

    SELECT
        sender_account AS account_id,
        COUNT(*) AS sender_activity_count
    FROM {{ ref('fct_transactions') }}
    GROUP BY sender_account

),

receiver_activity AS (

    SELECT
        receiver_account AS account_id,
        COUNT(*) AS receiver_activity_count
    FROM {{ ref('fct_transactions') }}
    GROUP BY receiver_account

)

SELECT

    f.transaction_key,

    f.step,

    f.payment_type,

    f.amount,

    f.sender_account,

    f.receiver_account,

    f.sender_old_balance,

    f.sender_new_balance,

    f.receiver_old_balance,

    f.receiver_new_balance,

    (f.sender_old_balance - f.sender_new_balance) AS sender_balance_change,

    (f.receiver_new_balance - f.receiver_old_balance) AS receiver_balance_change,

    CASE
        WHEN f.sender_old_balance = 0 THEN NULL
        ELSE f.amount / f.sender_old_balance
    END AS balance_change_ratio,

    COALESCE(s.sender_activity_count, 0) AS sender_activity_count,

    COALESCE(r.receiver_activity_count, 0) AS receiver_activity_count,

    CAST(
        COALESCE(s.sender_activity_count, 0)
        + COALESCE(r.receiver_activity_count, 0)
        AS INT
    ) AS overall_activity_count,

    CASE
        WHEN f.amount > 100000 THEN 1
        ELSE 0
    END AS is_large_transaction,

    CASE
        WHEN f.sender_old_balance = f.sender_new_balance
             AND f.amount > 0
        THEN 1
        ELSE 0
    END AS sender_balance_unchanged_flag,

    f.is_flagged_fraud,

    f.is_fraud

FROM {{ ref('fct_transactions') }} AS f

LEFT JOIN sender_activity AS s
    ON f.sender_account = s.account_id

LEFT JOIN receiver_activity AS r
    ON f.receiver_account = r.account_id