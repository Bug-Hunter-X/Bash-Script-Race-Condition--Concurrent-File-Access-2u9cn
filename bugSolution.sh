#!/bin/bash

# This script addresses the race condition by using a lock file.

file="my_data.txt"
lockfile="my_data.lock"

# Process 1: Writes data to the file
( flock "$lockfile" ; echo "Data 1" >> "$file" ; echo "Data 2" >> "$file" ; flock -u "$lockfile") &

# Process 2: Reads and processes the file concurrently
( while true; do
  flock "$lockfile" || continue #Wait for the lock
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
  flock -u "$lockfile"
 done ) &

wait