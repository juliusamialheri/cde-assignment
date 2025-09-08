#!/bin/bash
source ./config.sh

# Transform
# Now I am creating the 'Transformed' directory
mkdir -p "$TRANSFORMED_DIR"
echo "directory created: '$TRANSFORMED_DIR'."

# I will use awk for transformation
# 1. Rename Variable_code column to variable_code in the header.
# 2. Select only the specified columns: year, Value, Units, and variable_code.
awk -F',' '
BEGIN {
    OFS=","
    col_year=-1; col_value=-1; col_units=-1; col_variable_code=-1;
}
NR==1 {
    for (i=1; i<=NF; i++) {
        if ($i == "Year") col_year = i;
        else if ($i == "Value") col_value = i;
        else if ($i == "Units") col_units = i;
        else if ($i == "Variable_code") {
            col_variable_code = i;
            $i = "variable_code";
        }
    }
    if (col_year == -1 || col_value == -1 || col_units == -1 || col_variable_code == -1) {
        print "One or more required columns (Year, Value, Units, Variable_code) not found in the CSV header." > "/dev/stderr"
        exit 1
    }
    print $col_year, $col_value, $col_units, $col_variable_code
}
NR>1 {
    print $col_year, $col_value, $col_units, $col_variable_code
}' "$FULL_RAW_PATH" > "$FULL_TRANSFORMED_PATH"

TRANSFORM_STATUS=$?
echo "The Variable_code has been changed to variable_code"

# Confirm that the transformed file has been saved in the 'Transformed' folder
if [ $TRANSFORM_STATUS -eq 0 ] && [ -f "$FULL_TRANSFORMED_PATH" ]; then
    echo "Data transformed and saved to '$FULL_TRANSFORMED_PATH'."
else
    echo "Transformation failed or output file not created. Awk command exit status: $TRANSFORM_STATUS."
    exit 1
fi