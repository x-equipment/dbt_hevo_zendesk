{{
  config (
    materialized="ephemeral",
    required_tests=none
  )
}}

{% set __ref = namespace(id = "zendesk", model = "ticket_field") %}

select

  concat_ws('.', ticket.id, __flatten.seq, __flatten.index) as ticket_field_id,

  ticket.id::varchar as ticket_id,

  ticket.fields::array as field,

  __flatten.seq::varchar as field_seq,
  __flatten.index::varchar as field_index,
  trim(__flatten.value:id::varchar) as field_id,
  trim({{ __ref.model }}.type)::varchar as field_type,
  trim({{ __ref.model }}.title)::varchar as field_label,
  trim(__flatten.value:value::varchar) as field_value,

  cast('{{ __ref.id }}' as varchar(64)) as __source_id,
  to_timestamp(ticket.__hevo__loaded_at, 3) as __source_loaded_at

from
  {{ source(__ref.id,"ticket") }} as ticket,
  table(flatten(input=>fields, recursive => false)) as __flatten

inner join
  {{ source(__ref.id,__ref.model) }} as {{ __ref.model }}
on ({{ __ref.model }}.id = __flatten.value:id)

where
  true

and
  __flatten.value:value is not null