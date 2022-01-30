#!/bin/bash
> error.log

if [ -z "$1" ]; then
  echo "There is no the first arg" >> error.log
fi
if [ -z "$2" ]; then
  echo "There is no the second arg" >> error.log
fi
if [ -z "$3" ]; then
  echo "There is no the third arg" >> error.log
fi

DIRBACKUP=$1
COMPRESSIONALGO=$2
FILENAME=$3

case $COMPRESSIONALGO in
  tar)
    tar -czf $FILENAME $DIRBACKUP 2>> error.log ;;
  gzip)
    gzip $DIRBACKUP 2>> error.log ;;
  zip)
    zip -r $FILENAME $DIRBACKUP 2>> error.log ;;
  bzip2)
    bzip2 $DIRBACKUP 2>> error.log ;;
  none)
    echo "None parametr has been choosen" ;;
  *)
    echo "Unknown compression algo" >> error.log
esac


if [ -e "$FILENAME" ]; then
  openssl enc -aes-256-cbc -in "$FILENAME" -out "$FILENAME" 2>> error.log
elif [ -e "$FILENAME.gz" ]; then
    openssl enc -aes-256-cbc -in "$FILENAME.gz" -out "$FILENAME.gz" 2>> error.log
elif [ -e "$FILENAME.zip" ]; then
    openssl enc -aes-256-cbc -in "$FILENAME.zip" -out "$FILENAME.zip" 2>> error.log
elif [ -e "$FILENAME.bz2" ]; then
    openssl enc -aes-256-cbc -in "$FILENAME.bz2" -out "$FILENAME.bz2" 2>> error.log
fi

#We can do it also thought pipes, like
# tar -czf $FILENAME $DIRBACKUP 2>> error.log | openssl enc -aes-256-cbc -out "$FILENAME" 2>> error.log;;
