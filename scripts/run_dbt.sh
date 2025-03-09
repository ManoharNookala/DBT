#!/bin/bash

# Ensure script stops on error
set -e

# Load Environment Variables (GitHub Actions or Local)
export DBT_TARGET=${DBT_TARGET:-staging}  # Default to 'staging' if not set
export GCP_PROJECT_ID=${GCP_PROJECT_ID}
export STAGING_DATASET=${STAGING_DATASET}
export ODP_DATASET=${ODP_DATASET}
export GCP_CREDENTIALS=${GCP_CREDENTIALS}

# Activate Python Virtual Environment (Optional)
# Uncomment if using a virtual environment
# source venv/bin/activate  

# Install dbt dependencies
python -m pip install --upgrade pip
pip install dbt-core==1.7.18 dbt-bigquery==1.7.9

# Run dbt commands
dbt debug --profiles-dir ./profiles --target $DBT_TARGET
dbt compile --profiles-dir ./profiles --target $DBT_TARGET
dbt run --profiles-dir ./profiles --target staging    # Landing → Staging
dbt run --profiles-dir ./profiles --target odp_final  # Staging → ODP
dbt test --profiles-dir ./profiles --target odp_final  # Testing final dataset

# Cleanup credentials
rm -f $HOME/service_account.json
