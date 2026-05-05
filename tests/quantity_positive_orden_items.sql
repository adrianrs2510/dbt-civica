SELECT *
FROM {{ source('postgres', 'orderitems') }}
WHERE quantity < 0