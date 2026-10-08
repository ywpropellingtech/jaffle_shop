# Analytics dbt Project

A dbt project for transforming data in Snowflake.

## Setup Instructions

### 1. Install dbt Snowflake Adapter

```bash
pip install dbt-snowflake
```

### 2. Configure Snowflake Connection

Edit `profiles.yml` with your Snowflake credentials:

```yaml
Analytics:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: xy12345.us-east-1          # Your Snowflake account ID
      user: your_username                  # Your username
      password: your_password              # Your password (or use keychain)
      role: ANALYST                        # Your Snowflake role
      database: RAW_DATA                   # Your database
      schema: analytics_dev                # Your schema
      threads: 4
      client_session_keep_alive: False
```

**Note:** Store `profiles.yml` in `~/.dbt/profiles.yml` (recommended) instead of the project for better security.

### 3. Install Dependencies

```bash
dbt deps
```

### 4. Test Connection

```bash
dbt debug
```

### 5. Run Models

```bash
dbt run
```

## Project Structure

```
Analytics/
├── models/
│   ├── staging/    # Cleaned, deduplicated data
│   └── marts/      # Business logic and aggregations
├── tests/          # Data quality tests
├── macros/         # Custom dbt macros
├── data/           # Static data files
└── seeds/          # Seed data (CSV files)
```

## Semantic Layer Setup

To enable the semantic layer:

1. Configure `semantic_model` in your models YAML files
2. Define metrics and dimensions
3. Install `dbt-semantic-layer` package

Example:

```yaml
semantic_models:
  - name: orders
    model: ref('stg_orders')
    defaults:
      agg_time_dimension: created_at
    measures:
      - name: order_count
        description: Count of orders
        agg: count
    dimensions:
      - name: order_id
        type: identifier
      - name: created_at
        type: time
        primary: true
        granularities: [day, month, year]
```

## Useful Commands

```bash
dbt run              # Run all models
dbt test             # Run data quality tests
dbt snapshot         # Create snapshots
dbt seed             # Load seed data
dbt docs generate    # Generate documentation
dbt docs serve       # Serve documentation locally
```

## Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Snowflake Setup](https://docs.getdbt.com/reference/warehouse-setups/snowflake-setup)
- [Semantic Layer Documentation](https://docs.getdbt.com/docs/use-cases/semantic-layer)
