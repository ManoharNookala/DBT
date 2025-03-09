{% macro generate_schema_name(custom_schema_name, node) %}
  {% if target.name == 'staging' %}
    return 'staging_dataset'
  {% elif target.name == 'production' %}
    return 'final_dataset'
  {% endif %}
{% endmacro %}
