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

#### Bindings ####
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

#### Functions ####
# Calculate
=(){ awk "BEGIN{ print $* }" ;}

MDSSH()
{
# When ssh target starts with md, deconstruct the string and hop to the correct md machine.
# Otherwise, just give the usual ssh command.
        cmdargs=($@)
	while true
	do
		case $1 in
			md*)	target=$1 ;;
			*)	shift ;;
		esac
		# Emulated do-while loop	
		[[ $# -gt 1 ]] || break
	done
        if [ "${target:0:2}" == "md" ]
        then
		cmdargs=($(echo ${cmdargs[@]} | sed 's/md..//'))
                \ssh -o ProxyCommand="ssh -q md nc -q0 $1 22" ${cmdargs[@]} $target
        else
                \ssh ${cmdargs[@]}
        fi
}; alias ssh='MDSSH'

#### Aliases ####
alias q='exit'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias open='xdg-open'
