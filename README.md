# Bash Script Race Condition

This repository demonstrates a race condition in a bash script that involves concurrent file access.  The script attempts to write data to a file and read data from the same file simultaneously.  Due to the lack of proper synchronization, the reader may encounter incomplete or corrupted data.

The `bug.sh` script showcases the race condition. The `bugSolution.sh` script provides a solution using a lock file to synchronize the processes.

## How to reproduce

1. Clone this repository.
2. Run `bug.sh`.
3. Observe the output.  You'll likely see incomplete data processed, or inconsistent output each time.

## Solution

The `bugSolution.sh` script addresses the issue by using a lock file to ensure that only one process accesses the file at a time.