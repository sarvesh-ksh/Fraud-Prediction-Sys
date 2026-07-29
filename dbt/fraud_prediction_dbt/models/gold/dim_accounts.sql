WITH accounts AS (

    SELECT sender_account AS account_id
    FROM {{ ref('fct_transactions') }}

    UNION DISTINCT

    SELECT receiver_account AS account_id
    FROM {{ ref('fct_transactions') }}

),

sent_summary AS (

    SELECT
        sender_account AS account_id,
        SUM(amount) AS total_sent_amount
    FROM {{ ref('fct_transactions') }}
    GROUP BY sender_account

),

received_summary AS (

    SELECT
        receiver_account AS account_id,
        SUM(amount) AS total_received_amount
    FROM {{ ref('fct_transactions') }}
    GROUP BY receiver_account

)

SELECT

    a.account_id,

    COALESCE(s.total_sent_amount, 0) AS total_sent_amount,

    COALESCE(r.total_received_amount, 0) AS total_received_amount,

    CASE
        WHEN a.account_id LIKE 'C%' THEN 'Customer'
        WHEN a.account_id LIKE 'M%' THEN 'Merchant'
        ELSE 'Unknown'
    END AS account_type

FROM accounts a

LEFT JOIN sent_summary s
    ON a.account_id = s.account_id

LEFT JOIN received_summary r
    ON a.account_id = r.account_id