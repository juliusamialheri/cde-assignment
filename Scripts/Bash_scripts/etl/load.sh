#!/bin/bash
source ./config.sh

# Load
# Now to create the Gold directory
mkdir -p "$GOLD_DIR"
echo "directory created '$GOLD_DIR'."

# Move the transformed file from the Transformed directory to the Gold directory
mv "$FULL_TRANSFORMED_PATH" "$FULL_GOLD_PATH"
MV_STATUS=$?
echo "Moving the transformed file"

# To confirm that the file has been saved in the Gold folder
if [ $MV_STATUS -eq 0 ] && [ -f "$FULL_GOLD_PATH" ]; then #
    echo "Transformed data moved to '$FULL_GOLD_PATH'."
else
    echo "Failed to move data to the Gold directory. Mv exit status: $MV_STATUS."
    exit 1
fi
