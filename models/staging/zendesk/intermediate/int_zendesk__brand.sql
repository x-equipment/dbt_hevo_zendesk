{{
  config (
    materialized="ephemeral",
    required_tests=none
  )
}}

{% set __ref = namespace(id = "zendesk", model = "brand") %}

select

  {{ __ref.model }}.id::varchar as brand_id,
  {{ __ref.model }}.created_at::timestamp as created_at,
  {{ __ref.model }}.updated_at::timestamp as updated_at,
  {{ __ref.model }}.name::varchar as brand,
  {{ __ref.model }}.brand_url::varchar as brand_url,
  {{ __ref.model }}.subdomain::varchar as brand_subdomain,

  {{ __ref.model }}.active::boolean as is_active,
  {{ __ref.model }}.default::boolean as is_default,
  {{ __ref.model }}.is_deleted::boolean as is_archived,

  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __hevo__ingested_at,
  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __hevo__loaded_at,

  cast('{{ __ref.id }}' as varchar(64)) as __source_id,
  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __source_loaded_at

from
  {{ source(__ref.id,__ref.model) }} as {{ __ref.model }}

where
  true