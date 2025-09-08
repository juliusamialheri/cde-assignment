#!/bin/bash

# Name: Julius Sami Alheri
# Started on 9/1/2025

# Environment variable declaration, 
# define the URL for the CSV file as an environment variable.
export CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv" #

# Define directory and file names for clarity and identification
RAW_DIR="raw"
TRANSFORMED_DIR="Transformed"
GOLD_DIR="Gold"
RAW_FILE_NAME="annual-enterprise-survey-2023-financial-year-provisional.csv"
TRANSFORMED_FILE_NAME="2023_year_finance.csv"
echo "Setting up directory structure..."

# Construct paths for files
FULL_RAW_PATH="$RAW_DIR/$RAW_FILE_NAME"
FULL_TRANSFORMED_PATH="$TRANSFORMED_DIR/$TRANSFORMED_FILE_NAME"
FULL_GOLD_PATH="$GOLD_DIR/$TRANSFORMED_FILE_NAME"
