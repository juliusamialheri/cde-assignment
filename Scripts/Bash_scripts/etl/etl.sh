#!/bin/bash
set -e

# Calling the other scripts
./extract.sh
./transform.sh
./load.sh

echo "Yayyyyyy ETL process completed successfully"