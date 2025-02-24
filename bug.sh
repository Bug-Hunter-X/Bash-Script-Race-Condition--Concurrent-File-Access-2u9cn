#!/bin/bash

# This script attempts to process a file, but it has a subtle race condition.
# The problem lies in how the file is accessed and updated.  The file may be
# partially written when another process tries to read from it.

# This error will be noticed on multicore systems more often because it is 
# more likely for another process to interrupt the file writing operation

file="my_data.txt"

# Process 1: Writes data to the file
( echo "Data 1" >> "$file" ; echo "Data 2" >> "$file" ) &

# Process 2: Reads and processes the file concurrently
( while true; do
  data=$(cat "$file")
  if [[ -n "$data" ]]; then
    echo "Processing: $data"
    # Simulate some processing time
    sleep 0.1
  fi
  if [[ "$data" == "Data 1\nData 2" ]]; then
    echo "Processing finished"
    break
  fi
 done ) &

wait