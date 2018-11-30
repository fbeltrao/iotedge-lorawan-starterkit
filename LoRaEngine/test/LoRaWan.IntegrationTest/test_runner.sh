#!/bin/bash

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

echo "ABPTest starting"
retry dotnet test --filter ABPTest --logger trx --results-directory /vsts-agent/_work/_temp

echo "C2DMessageTest"
retry dotnet test --filter C2DMessageTest --logger trx --results-directory /vsts-agent/_work/_temp

echo "OTAAJoinTest"
retry dotnet test --filter OTAAJoinTest --logger trx --results-directory /vsts-agent/_work/_temp

echo "OTAATest"
retry dotnet test --filter OTAATest --logger trx --results-directory /vsts-agent/_work/_temp

echo "SensorDecodingTest"
retry dotnet test --filter SensorDecodingTest --logger trx --results-directory /vsts-agent/_work/_temp

echo "Done executing tests"