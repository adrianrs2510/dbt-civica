{{
    config(
        materialized='incremental',
        unique_key = 'product_id',
        incremental_strategy = 'delete+insert'
    )
}}
with 

source as (

    select * from {{ source('postgres', 'products') }}
    {% if is_incremental() %}

        where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

    {% endif %}

),

renamed as (

    select
        product_id,
        price,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed

