{% macro generate_schema_name(custom_schema_name, node) %}
    -- If custom_schema_name is None, set a default value
    {% set custom_schema_name = custom_schema_name or 'default_schema' %}

    -- Remove 'odp_' prefix if present
    {% if custom_schema_name.startswith('odp_') %}
        {% set new_schema = custom_schema_name | replace('odp_', '') %}
    {% else %}
        {% set new_schema = custom_schema_name %}
    {% endif %}

    {{ return(new_schema) }}
{% endmacro %}
