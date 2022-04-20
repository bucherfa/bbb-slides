#!/usr/bin/env bash

TEMP_FOLDER="./temp/"

# check for url in arguments
if [ -z "$1" ]; then
  echo "No url provided. Usage:"
  echo "./main.sh <bbb slides url> [start slide] [end slide]"
  exit 1
fi
URL=$1

mkdir -p $TEMP_FOLDER

# set start index if provided
if [ -z "$2" ]; then
  index=1
else
  index=$2
fi
startIndex=$index

# set end index if provided
if [ -z "$3" ]; then
  maxIndex=-1
else
  maxIndex=$3
fi

# gather slides
while (( maxIndex == -1 || index < maxIndex + 1 ))
do
  # https://stackoverflow.com/a/55434980
  http_response=$(curl -s -o "$TEMP_FOLDER/$index" -w "%{http_code}" "$URL$index")
  # break on error
  if [ $http_response != "200" ]; then
    if [ $http_response != "404" ]; then
      echo "Unexpected error: $http_response"
      cat $TEMP_FOLDER/$index
    fi
    rm $TEMP_FOLDER/$index
    break
  # otherwise keep going by checking for a next slide
  else
    ((index++))
  fi
done

cd $TEMP_FOLDER

# convert each svg into a pdf file
for file in *;
do
  rsvg-convert -f pdf -o "$file.pdf" "$file";
done

# merge all pdfs together
eval pdfunite {$startIndex.."$(($index - 1))"}.pdf ../out.pdf

cd ..

# clean up
rm -rf $TEMP_FOLDER

echo "PDF successfully generated and saved as out.pdf. ($(($index - $startIndex)) slides)"
