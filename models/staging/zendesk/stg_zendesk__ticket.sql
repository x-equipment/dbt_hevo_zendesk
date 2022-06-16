with __source as (
  select
    *
  from
    {{ ref('int_zendesk__ticket') }}
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
    *
  from
    __enrich
)

select * from __target