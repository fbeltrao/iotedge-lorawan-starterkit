#!/bin/bash

TEST_RESULTS_PATH="./TestResults"

function fail {
  echo $1 >&2
  exit 1
}

trap 'fail "The execution was aborted because a command exited with an error status code."' ERR


function retry {
  local n=1
  local max=3
  local delay=5
  while true; do
    "$@" && break || {
      if [[ $n -lt $max ]]; then
        ((n++))
        echo "Test failed. Attempt $n/$max:"
        sleep $delay;
      else
        fail "The test has failed after $n attempts."
      fi
    }
  done
}



if [ "$1" != "" ]; then
    TEST_RESULTS_PATH="$1"
fi


retry dotnet test --filter RandomTest --logger trx --results-directory $TEST_RESULTS_PATH
retry dotnet test --filter Should_Find_String_If_Case_Matches --logger trx --results-directory $TEST_RESULTS_PATH
retry dotnet test --filter Should_Find_String_If_Case_Does_Not_Match --logger trx --results-directory $TEST_RESULTS_PATH
retry dotnet test --filter It_Never_Works --logger trx --results-directory $TEST_RESULTS_PATH

echo "Done executing tests"