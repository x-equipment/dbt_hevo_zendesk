{{
  config (
    materialized="ephemeral",
    required_tests=none
  )
}}

{% set __ref = namespace(id = "zendesk", model = "satisfaction_rating") %}

select

  {{ __ref.model }}.id::varchar as rating_id,
  {{ __ref.model }}.created_at::timestamp as created_at,
  {{ __ref.model }}.updated_at::timestamp as updated_at,

  {{ __ref.model }}.score::varchar as score,

  {{ __ref.model }}.reason_id::varchar as reason_id,
  {{ __ref.model }}.reason::varchar as reason,

  {{ __ref.model }}.comment::varchar as rating_comment,

  {{ __ref.model }}.ticket_id::varchar as ticket_id,
  {{ __ref.model }}.assignee_id::varchar as assignee_id,
  {{ __ref.model }}.requester_id::varchar as requester_id,
  {{ __ref.model }}.group_id::varchar as team_id,

  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __hevo__ingested_at,
  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __hevo__loaded_at,

  cast('{{ __ref.id }}' as varchar(64)) as __source_id,
  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __source_loaded_at

from
  {{ source(__ref.id,__ref.model) }} as {{ __ref.model }}

where
  true