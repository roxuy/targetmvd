#!/usr/bin/env bash

echo "Running pre-commit hook"
./scripts/run-rubocop.bash
./scripts/run-brakeman.bash
./scripts/run-rspec.bash

# $? stores exit value of the last command
if [ $? -ne 0 ]; then
 echo "Code must be clean before commiting"
 exit 1
fi