SELECT *
FROM {{ source('google_sheets', 'budget') }}
WHERE quantity < 0