{{
  config (
    materialized="ephemeral",
    required_tests=none
  )
}}

{% set __ref = namespace(id = "zendesk", model = "ticket") %}

select

  {{ __ref.model }}.id::varchar as ticket_id,

  trim(__flatten.value::varchar) as tag,

  cast('{{ __ref.id }}' as varchar(64)) as __source_id,
  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __source_loaded_at

from
  {{ source(__ref.id,__ref.model) }} as {{ __ref.model }},
  table(flatten(input=>tags, recursive => true)) as __flatten

where
  true