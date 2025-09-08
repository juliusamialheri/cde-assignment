#!/bin/bash

# Load environmental variables
source .env
 
# Export password for psql
export PGPASSWORD="$DB_PASSWORD"

# Testing database connection
echo "Testing postgres connection..."
psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d postgres -c "SELECT version();" || { echo "Connection failed"; exit 1; }
echo "Connection successful"

# Create database if it doesn't exist
DB_EXIST=$(psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'")
if [ "$DB_EXIST" != "1" ]; then
    echo "Creating database $DB_NAME..."
    createdb -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" "$DB_NAME"
fi

# Create schema
psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -c "CREATE SCHEMA IF NOT EXISTS \"$SCHEMA_NAME\";"

# Load CSV files
SOURCE_FOLDER="$(pwd)/CSV"
for file in "$SOURCE_FOLDER"/*.csv; do
    [ ! -f "$file" ] && continue
    
    filename=$(basename "$file")
    table_name="${filename%.csv}"
    
    # Normalizing line endings and extract header
    sed -i 's/\r$//' "$file"
    header=$(head -n 1 "$file")
    
    # Converting header to PostgreSQL columns
    columns=$(echo "$header" | sed -E 's/[^a-zA-Z0-9_,]/_/g; s/ /_/g; s/,/ TEXT,/g')
    columns="${columns} TEXT"
    
    # Create table and load data
    psql -v ON_ERROR_STOP=1 -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -c "
        DROP TABLE IF EXISTS \"$SCHEMA_NAME\".\"$table_name\";
        CREATE TABLE \"$SCHEMA_NAME\".\"$table_name\" ($columns);
    "
    win_file_path=$(cygpath -w "$file")
    psql -v ON_ERROR_STOP=1 -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" <<EOF
\copy "$SCHEMA_NAME"."$table_name" FROM '$win_file_path' WITH (FORMAT csv, HEADER true, DELIMITER ',');
EOF
    
    echo "Loaded $filename into $SCHEMA_NAME.$table_name"
done

echo "All CSV files loaded into schema $SCHEMA_NAME"