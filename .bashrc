# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#### Bash prompt customization ####
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

#### Sources ####
if [[ -z $gmxpath ]]
then
	if [[ $(pacman -Qq gromacs &> /dev/null) ]]
	then
		export gmxpath=$(pacman -Ql gromacs | grep "/bin/gmx$" | cut -f2 -d' ')
	. ${gmxpath%gmx}/GMXRC.bash
	. ${gmxpath%gmx}/gmx-completion.bash
	fi
fi

#### Exports ####
export EDITOR="vim"
export PATH="$PATH:$HOME/.local/bin/"
export TODAY="$(date +%d-%m-%y)"

#### Bindings ####
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

#### Functions ####
# Calculate
=(){ awk "BEGIN{ print $* }" ;}

_ssh(){
# When ssh target starts with md, deconstruct the string and hop to the correct md machine.
# Otherwise, just give the usual ssh command.
    local target
    target=$(echo $@ | grep -o "md[0-9][0-9]")
    if [ $target ]
    then
        local cmdargs
    	cmdargs=$(echo "$@" | sed "s/$target//")
        \ssh $cmdargs -o ProxyCommand="ssh -q md nc -q0 $target 22" $target
    else
        \ssh $@
    fi
}; alias ssh='_ssh'

updmrs(){
    # Check for reflector 
    \pacman -Qq reflector &> /dev/null || sudo \pacman -S reflector || return 1
    local="es" # currently living in spain
    cc=()
    if [[ $# -eq 0 ]]
    then
        cc+="-c ${local}"
    fi
    while [[ $# -ge 1 ]]
    do
        case $1 in
            *) cc+="-c ${1} "; shift ;;
        esac
    done
    sudo sh -c "reflector $cc | tee /etc/pacman.d/mirrorlist"
}

#### Aliases ####
alias q='exit'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias open='xdg-open'
alias ROSETTARC=". $HOME/.local/bin/ROSETTARC"
