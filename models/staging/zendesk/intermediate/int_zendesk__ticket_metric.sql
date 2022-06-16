{{
  config (
    materialized="ephemeral",
    required_tests=none
  )
}}

{% set __ref = namespace(id = "zendesk", model = "ticket_metric") %}

select

  {{ __ref.model }}.id::varchar as metric_id,
  {{ __ref.model }}.created_at::timestamp as created_at,
  {{ __ref.model }}.updated_at::timestamp as updated_at,

  {{ __ref.model }}.requester_updated_at::timestamp as ticket_requester_updated_at,
  {{ __ref.model }}.status_updated_at::timestamp as ticket_status_updated_at,
  {{ __ref.model }}.solved_at::timestamp as ticket_solved_at,
  {{ __ref.model }}.latest_comment_added_at::timestamp as ticket_latest_comment_added_at,

  {{ __ref.model }}.assignee_updated_at::timestamp as ticket_assignee_updated_at,
  {{ __ref.model }}.initially_assigned_at::timestamp as ticket_initially_assigned_at,
  {{ __ref.model }}.assigned_at::timestamp as ticket_assigned_at,

  {{ __ref.model }}.group_stations::integer as ticket_group_stations,
  {{ __ref.model }}.assignee_stations::integer as ticket_assignee_stations,
  {{ __ref.model }}.reopens::integer as ticket_reopens,
  {{ __ref.model }}.replies::integer as ticket_replies,

  {{ __ref.model }}.ticket_id::varchar as ticket_id,

  {{ __ref.model }}.reply_time_in_minutes::object as ticket_reply_time_in_minutes,

  {{ __ref.model }}.reply_time_in_minutes:calendar::integer as ticket_reply_time_in_minutes_calendar,
  {{ __ref.model }}.reply_time_in_minutes:business::integer as ticket_reply_time_in_minutes_business,

  {{ __ref.model }}.first_resolution_time_in_minutes::object as ticket_first_resolution_time_in_minutes,

  {{ __ref.model }}.first_resolution_time_in_minutes:calendar::integer as ticket_first_resolution_time_in_minutes_calendar,
  {{ __ref.model }}.first_resolution_time_in_minutes:business::integer as ticket_first_resolution_time_in_minutes_business,

  {{ __ref.model }}.full_resolution_time_in_minutes::object as ticket_full_resolution_time_in_minutes,

  {{ __ref.model }}.full_resolution_time_in_minutes:calendar::integer as ticket_full_resolution_time_in_minutes_calendar,
  {{ __ref.model }}.full_resolution_time_in_minutes:business::integer as ticket_full_resolution_time_in_minutes_business,

  {{ __ref.model }}.agent_wait_time_in_minutes::object as ticket_agent_wait_time_in_minutes,

  {{ __ref.model }}.agent_wait_time_in_minutes:calendar::integer as ticket_agent_wait_time_in_minutes_calendar,
  {{ __ref.model }}.agent_wait_time_in_minutes:business::integer as ticket_agent_wait_time_in_minutes_business,

  {{ __ref.model }}.requester_wait_time_in_minutes::object as ticket_requester_wait_time_in_minutes,

  {{ __ref.model }}.requester_wait_time_in_minutes:calendar::integer as ticket_requester_wait_time_in_minutes_calendar,
  {{ __ref.model }}.requester_wait_time_in_minutes:business::integer as ticket_requester_wait_time_in_minutes_business,

  {{ __ref.model }}.on_hold_time_in_minutes::object as ticket_on_hold_time_in_minutes,

  {{ __ref.model }}.on_hold_time_in_minutes:calendar::integer as ticket_on_hold_time_in_minutes_calendar,
  {{ __ref.model }}.on_hold_time_in_minutes:business::integer as ticket_on_hold_time_in_minutes_business,

  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __hevo__ingested_at,
  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __hevo__loaded_at,

  cast('{{ __ref.id }}' as varchar(64)) as __source_id,
  to_timestamp({{ __ref.model }}.__hevo__loaded_at, 3) as __source_loaded_at

from
  {{ source(__ref.id,__ref.model) }} as {{ __ref.model }}

where
  true