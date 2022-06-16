{{
  config (
    materialized="ephemeral",
    required_tests=none
  )
}}

{% set __ref = namespace(id = "zendesk", model = "ticket") %}

select

  {{ __ref.model }}.id::varchar as ticket_id,
  {{ __ref.model }}.created_at::timestamp as created_at,
  {{ __ref.model }}.updated_at::timestamp as updated_at,

  {{ __ref.model }}.type::varchar as ticket_type,
  {{ __ref.model }}.subject::varchar as ticket_subject,
  {{ __ref.model }}.description::varchar as ticket_description,
  {{ __ref.model }}.priority::varchar as ticket_priority,
  {{ __ref.model }}.status::varchar as ticket_status,

  {{ __ref.model }}.recipient::varchar as recipient,

  {{ __ref.model }}.assignee_id::varchar as assignee_id,
  {{ __ref.model }}.brand_id::varchar as brand_id,
  {{ __ref.model }}.requester_id::varchar as requester_id,
  {{ __ref.model }}.submitter_id::varchar as submitter_id,
  {{ __ref.model }}.organization_id::varchar as organization_id,
  {{ __ref.model }}.group_id::varchar as team_id,

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