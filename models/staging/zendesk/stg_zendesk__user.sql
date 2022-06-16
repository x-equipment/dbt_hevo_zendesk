{% set __ref = namespace(model = "user") %}

with __source as (
  select
    *
  from
    {{ ref('int_zendesk__user') }}
),

__cleans as (
  select
    *
  from
    __source
),

__prepare as (
  select
    *
  from
    __cleans
),

__enrich as (
  select
    *
  from
    __prepare
),

__target as (
  select
    

    user_id as {{ __ref.model }}_id,
    created_at,
    updated_at,
    user as {{ __ref.model }},
    user_email as {{ __ref.model }}_email,

    is_active,
    is_moderator,
    is_verified,
    is_suspended,
    is_archived,

    __hevo__ingested_at,
    __hevo__loaded_at,

    __source_id,
    __source_loaded_at

  from
    __enrich
)

select * from __target