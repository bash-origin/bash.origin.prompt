#!/usr/bin/env bash.origin.script


function EXPORTS_setWorkspacePrompt {
    BO_PROMPT_ORIGIN_ROOT_PATH="$1"
    ORIGIN_CONTEXT="$2"
    BO_PROMPT_ORIGIN_NAME=""
    if [ "$BO_PROMPT_ORIGIN_ROOT_PATH" != "" ]; then
        BO_PROMPT_ORIGIN_NAME="$(basename "$BO_PROMPT_ORIGIN_ROOT_PATH")"
    fi

    function parse_git_branch {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
    }
    function get_sub_path {
        BO_PROMPT_WORKING_PATH=$(pwd)
        if [ "${BO_PROMPT_WORKING_PATH,,}" != "${BO_PROMPT_ORIGIN_ROOT_PATH,,}" ]; then
            if [[ "${BO_PROMPT_WORKING_PATH,,}" == "${BO_PROMPT_ORIGIN_ROOT_PATH,,}"* ]]; then
                echo -e "\033[33m./${BO_PROMPT_WORKING_PATH#$BO_PROMPT_ORIGIN_ROOT_PATH/}\033[0m "
            else
                echo -e "\033[1;31mWARNING Current working directory '${BO_PROMPT_WORKING_PATH#$BO_PROMPT_ORIGIN_ROOT_PATH/}' is OUTSIDE of workspace root '$BO_PROMPT_ORIGIN_ROOT_PATH'\033[0m"
            fi
        fi
    }
    function get_context {
        if [ ! -z "$ORIGIN_CONTEXT" ]; then
            if [ "${!ORIGIN_CONTEXT}" != "" ]; then
                echo -e "\033[36m(${!ORIGIN_CONTEXT})\033[0m"
            fi
        fi
    }

    # @see http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
    # @see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
    export PS1='\[\033[1;34m\]\[\033[47m\]$BO_PROMPT_ORIGIN_NAME\[\033[0m\] \[\033[1;35m\]$(parse_git_branch)\[\033[0m\]$(get_sub_path)$(get_context)\[\033[1;33m\]$\[\033[0m\] '
}

function EXPORTS_setPrompt {
    if [ "$1" == "workspace" ]; then
        EXPORTS_setWorkspacePrompt ${*:2}
    else
        # TODO: Prefix with plugin log prefix or use log function.
        echo "ERROR: Prompt of type '$1' not found!"
    fi
}

function EXPORTS_askForInput {
    if [ ! -z "$2" ]; then
        echo -n "$1 [$2]:"
    else
        echo -n "$1: "
    fi
    read answer
    if [ "$answer" == "" ]; then
        answer="$2"
    fi
    echo "$answer"
}
