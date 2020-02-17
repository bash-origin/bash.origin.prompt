#!/usr/bin/env bash.origin.script

depend {
    "prompt": "bash.origin.prompt # prompt/v0"
}

CALL_prompt setPrompt "workspace" "context"

echo "$PS1"

echo "OK"
