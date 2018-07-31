# .bashr
#UPD

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


# Color PS based on hostname
#tput setaf $(hostname | sum | awk -v ncolors=$(infocmp -1 | expand | sed -n -e "s/^ *colors#\([0-9][0-9]*\),.*/\1/p") 'ncolors>1 {print 1 + ($1 % (ncolors - 1))}')


# Bash completion support for ssh.

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_sshcomplete() {
    local CURRENT_PROMPT="${COMP_WORDS[COMP_CWORD]}"
    if [[ ${CURRENT_PROMPT} == *@*  ]] ; then
      local OPTIONS="-P ${CURRENT_PROMPT/@*/}@ -- ${CURRENT_PROMPT/*@/}"
    else
      local OPTIONS=" -- ${CURRENT_PROMPT}"
    fi

    # parse hosts defined in /etc/hosts
    if [ -r /etc/hosts ]; then
        COMPREPLY=( ${COMPREPLY[@]} $(compgen -W "$( grep -v '^[[:space:]]*$' /etc/hosts | grep -v '^#' | awk '{for (i=2; i<=NF; i++) print $i}' )" ${OPTIONS}) )
    fi

    return 0
}

complete -o default -o nospace -F _sshcomplete ssh scp ssh-copy-id ping telnet
