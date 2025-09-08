#!/bin/bash
source ./config.sh

# Extract
# Create the 'raw' directory 
mkdir -p "$RAW_DIR"
echo "directory created: '$RAW_DIR'."

# I am using curl command to download the CSV file
curl -o "$FULL_RAW_PATH" "$CSV_URL" &>/dev/null
CURL_STATUS=$?
echo "Extracting the data from the site: $CSV_URL"

# check that the file has been saved in the 'raw' folder
if [ $CURL_STATUS -eq 0 ] && [ -f "$FULL_RAW_PATH" ]; then #
    echo "File downloaded and saved to '$FULL_RAW_PATH'."
else
    echo "Failed to download the file. $CURL_STATUS. Please check the URL or network connection."
    exit 1
fi