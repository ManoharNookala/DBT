{% macro generate_schema_name(custom_schema_name, node) %}
    {% if custom_schema_name.startswith('odp_') %}
        {% set new_schema = custom_schema_name | replace('odp_', '') %}
    {% else %}
        {% set new_schema = custom_schema_name %}
    {% endif %}

    {{ return(new_schema) }}
{% endmacro %}
