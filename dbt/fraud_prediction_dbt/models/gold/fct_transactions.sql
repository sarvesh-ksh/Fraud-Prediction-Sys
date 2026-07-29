SELECT
    transaction_key,
    step,
    FLOOR((step - 1) / 24) + 1 AS day_number,
    MOD(step - 1, 24) AS hour_of_day,
    CASE MOD(step - 1, 24)
        WHEN 0 THEN '00:00'
        WHEN 1 THEN '01:00'
        WHEN 2 THEN '02:00'
        WHEN 3 THEN '03:00'
        WHEN 4 THEN '04:00'
        WHEN 5 THEN '05:00'
        WHEN 6 THEN '06:00'
        WHEN 7 THEN '07:00'
        WHEN 8 THEN '08:00'
        WHEN 9 THEN '09:00'
        WHEN 10 THEN '10:00'
        WHEN 11 THEN '11:00'
        WHEN 12 THEN '12:00'
        WHEN 13 THEN '13:00'
        WHEN 14 THEN '14:00'
        WHEN 15 THEN '15:00'
        WHEN 16 THEN '16:00'
        WHEN 17 THEN '17:00'
        WHEN 18 THEN '18:00'
        WHEN 19 THEN '19:00'
        WHEN 20 THEN '20:00'
        WHEN 21 THEN '21:00'
        WHEN 22 THEN '22:00'
        WHEN 23 THEN '23:00'
    END AS hour_label,

    CASE MOD(FLOOR((step - 1) / 24), 7)
        WHEN 0 THEN 'Monday'
        WHEN 1 THEN 'Tuesday'
        WHEN 2 THEN 'Wednesday'
        WHEN 3 THEN 'Thursday'
        WHEN 4 THEN 'Friday'
        WHEN 5 THEN 'Saturday'
        WHEN 6 THEN 'Sunday'
    END AS day_of_week,
    
    CASE
        WHEN MOD(step - 1,24) BETWEEN 0 AND 5 THEN 'Night'
        WHEN MOD(step - 1,24) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN MOD(step - 1,24) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day,
    payment_type,
    amount,
    sender_account,
    receiver_account,
    sender_old_balance,
    sender_new_balance,
    receiver_old_balance,
    receiver_new_balance,
    is_fraud,
    is_flagged_fraud
FROM
    {{ ref('stg_paysim') }}