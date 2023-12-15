#!/bin/bash

# URL of the server to which you are uploading
URL="http://localhost:8080/globber"

# Directory containing the files to upload
DIR="/home/nal/NP/GroundSeg/ui/build"

# Start building the curl command
#CMD="curl -X POST $URL"

# Loop over each file in the directory and its subdirectories
#while IFS= read -r -d '' file; do
#  CMD="$CMD -F \"file=@$file\""
#done < <(find "$DIR" -type f -print0)

# Execute the curl command
#eval $CMD

#!/bin/bash

# URL of the server to which you are uploading
#URL="http://example.com/upload"

# Directory containing the files to upload
#DIR="/path/to/directory"

# Start building the curl command
CMD="curl -X POST $URL"

# Find files and append them to the curl command with relative path
while IFS= read -r -d '' file; do
  # Get the relative file path
  REL_PATH="${file#$DIR/}"
  CMD="$CMD -F \"file=@$file;filename=$REL_PATH\""
done < <(find "$DIR" -type f -print0)

# Execute the curl command
eval $CMD
