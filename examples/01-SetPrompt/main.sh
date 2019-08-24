#!/usr/bin/env bash.origin.script

depend {
    "prompt": "@../..#s1"
}

CALL_prompt setPrompt "workspace" "context"

echo "$PS1"

echo "OK"
