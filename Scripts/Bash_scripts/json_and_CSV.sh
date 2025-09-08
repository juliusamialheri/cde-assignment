#!/bin/bash

# Script to move all CSV and JSON files to json_and_CSV folder

# Get source directory (default: current directory)
SOURCE_DIR=${1:-$(pwd)}
DEST_DIR="json_and_CSV"

# Validate source directory
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist!"
    exit 1
fi

# Create destination directory
mkdir -p "$DEST_DIR"

# Count files
csv_files=$(find "$SOURCE_DIR" -maxdepth 1 -name "*.csv" -type f | wc -l)
json_files=$(find "$SOURCE_DIR" -maxdepth 1 -name "*.json" -type f | wc -l)

echo "Found $csv_files CSV and $json_files JSON files"

# Move files if they exist
if [ $csv_files -gt 0 ]; then
    find "$SOURCE_DIR" -maxdepth 1 -name "*.csv" -type f -exec mv {} "$DEST_DIR" \;
    echo "Moved $csv_files CSV files"
fi

if [ $json_files -gt 0 ]; then
    find "$SOURCE_DIR" -maxdepth 1 -name "*.json" -type f -exec mv {} "$DEST_DIR" \;
    echo "Moved $json_files JSON files"
fi

echo "Done files moved to $DEST_DIR"