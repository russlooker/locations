view: locations {
  sql_table_name: public.locations ;;


  dimension: pk {
    type: number
    hidden: yes
    primary_key: yes
    sql:
    ${TABLE}."latitudeE7" ||
    ${TABLE}."longitudeE7" ||
    to_timestamp(${TABLE}."timestampMs"*1.0/1000)

    ;;
  }

  dimension: accuracy {
    type: number
    hidden: yes
    sql: ${TABLE}."accuracy ;;
  }

  dimension: altitude {
    type: number
    hidden: yes
    sql: ${TABLE}."altitude" ;;
  }

  dimension: latitude {
    type: number
    hidden: yes
    sql: ${TABLE}."latitudeE7"*1.0/10000000 ;;
  }

  dimension: longitude {
    type: number
    hidden: yes
    sql: ${TABLE}."longitudeE7"*1.0/10000000 ;;
  }

  dimension: location {
    type: location
    sql_latitude:  ${latitude};;
    sql_longitude:  ${longitude};;
  }

  dimension: approx_location {
    type: location
    sql_latitude:  round(${latitude},1);;
    sql_longitude:  round(${longitude},1);;
  }

  dimension_group: ts {
    type: time
#     timeframes: [date,month,year,time]
    sql: to_timestamp(${TABLE}."timestampMs"*1.0/1000) ;;
  }

  dimension: vertical_accuracy {
    type: number
    hidden: yes
    sql: ${TABLE}."verticalAccuracy" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: avg_velocity {
    type: average
    sql:  ${TABLE}."velocity";;
  }
}
