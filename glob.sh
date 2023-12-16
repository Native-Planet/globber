#!/bin/bash -x

DIR="$1"
if [ ! -d "$DIR" ]; then
    echo "Directory not found: $DIR"
    exit 1
fi

curl -L https://files.native.computer/glob/globzod.tar.xz -o globzod.tar.xz
ls
tar xf globzod.tar.xz
./zod/.run -d --http-port 8099

URL="http://localhost:8099/globber"
DIR_NAME=$(basename "$DIR")
CMD="curl -X POST $URL"

while IFS= read -r -d '' file; do
  REL_PATH="$DIR_NAME/${file#$DIR/}"
  MIME_TYPE=$(file --brief --mime-type "$file")

  case "$file" in
    *.woff2) MIME_TYPE="font/woff2" ;;
    *.js)    MIME_TYPE="application/javascript" ;;
    *.css)   MIME_TYPE="text/css" ;;
  esac

  CMD="$CMD -F \"file=@$file;filename=$REL_PATH;type=$MIME_TYPE\""
done < <(find "$DIR" -type f -print0)

RESPONSE=$(eval $CMD)

mv ./zod/.urb/put/*.glob .
rm -rf zod

# Check if the response contains <h1>success</h1>
if [[ $RESPONSE == *"<h1>success</h1>"* ]]; then
  echo "Upload successful."
else
  echo "Upload failed"
  echo $RESPONSE
fi
