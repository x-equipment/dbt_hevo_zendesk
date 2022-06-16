{{
  config (
    materialized="ephemeral",
    required_tests=none
  )
}}

{% set __ref = namespace(id = "zendesk", model = "ticket_comment") %}

select

  {{ __ref.model }}.id::varchar as comment_id,
  {{ __ref.model }}.created_at::timestamp as created_at,
  {{ __ref.model }}.created_at::timestamp as updated_at,

  {{ __ref.model }}.type::varchar as comment_type,
  {{ __ref.model }}.body::varchar as comment,

  {{ __ref.model }}.ticket_id::varchar as ticket_id,
  {{ __ref.model }}.author_id::varchar as user_id,

  {{ __ref.model }}.via::object as via,

  {{ __ref.model }}.via:channel::varchar as via_channel,
  {{ __ref.model }}.via:source.from.name::varchar as via_source_from_name,
  {{ __ref.model }}.via:source.from.address::varchar as via_source_from_address,
  {{ __ref.model }}.via:source.rel::varchar as via_source_rel,
  {{ __ref.model }}.via:source.to.name::varchar as via_source_to_name,
  {{ __ref.model }}.via:source.to.address::varchar as via_source_to_address,

  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __hevo__ingested_at,
  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __hevo__loaded_at,

  cast('{{ __ref.id }}' as varchar(64)) as __source_id,
  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __source_loaded_at

from
  {{ source(__ref.id,__ref.model) }} as {{ __ref.model }}

where
  true