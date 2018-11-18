# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash

#if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    #if [ -f "$HOME/.bashrc" ]; then
    #. "$HOME/.bashrc"
    #fi
#fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.linuxbrew" ] ; then
    PATH="$HOME/.linuxbrew/bin:$PATH"
fi

if [ -d "$HOME/sbks" ] ; then
    PATH="$HOME/sbks/arcanist/bin/:$PATH"
fi

function _jenkins() {
    local cur tasks
    cur="${COMP_WORDS[COMP_CWORD]}"
    tasks="$(~/bin/jenkins --jobs)"
    # if [ $COMP_CWORD -eq 1 ]; then
        # Task name completion for first argument.
        COMPREPLY=( $(compgen -W "$tasks" $cur) )
    # else
        # File name completion for other arguments.
        # COMPREPLY=( $(compgen -f $cur) )
    # fi
 
}
complete -o default -F _jenkins jenkins c

[[ -s /home/cizekm/.nvm/nvm.sh ]] && . /home/cizekm/.nvm/nvm.sh # This loads NVM
export NODE_EXTRA_CA_CERTS=/home/cizekm/Downloads/SBKSAdminCA.pem


# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time24h="\t"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

function node_version_alert() {
    if [ -f package.json ]; then
        DESIRED_NODE_VERSION=$(cat package.json | grep "\"node\"" | awk {'print $2'} | tr -d "\"^,")
        NODE_VERSION=$(node -v | tr -d v)
        # DESIRED_NPM_VERSION=$(cat package.json | grep "\"npm\"" | awk {'print $2'} | tr -d "\"^")
        # NPM_VERSION=$(npm -v)
        if [[ "$NODE_VERSION" != *"$DESIRED_NODE_VERSION"* ]]; then
            echo "node $DESIRED_NODE_VERSION "
        fi
    fi
}

function sbks_env() {
    if [ -f .env ]; then
        echo " $(cat .env | grep "ENVIRONMENT_NAME=" | cut -f 2 -d '=')"
    fi
}


# This PS1 snippet was adopted from code for MAC/BSD I saw from: http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better

source /etc/bash_completion.d/git-prompt
export PS1=$IBlack$Time24h$Color_Off'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
    echo " '$BBlue$PathShort$Color_Off$Yellow'$(sbks_env)'$Color_Off'$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
    if [ "$?" -eq "0" ]; then \
        # @4 - Clean repository - nothing to commit
        echo "'$Green'"$(__git_ps1 " (%s) '$IRed'$(node_version_alert)"'$Color_Off'); \
    else \
        # @5 - Changes to working tree
        echo "'$IRed'"$(__git_ps1 " [%s] '$IRed'$(node_version_alert)"'$Color_Off'); \
    fi)\$ "; \
else \
    # @2 - Prompt when not in GIT repo
    echo " '$BBlue$PathShort$Color_Off'\$ "; \
fi
)'


_sbks() {
 #clear
 cd /home/cizekm/sbks/$1
}
alias sbks=_sbks
complete -W "$(echo `sbks && ls | cut -f 1 -d ' ' | uniq | tr '\n' ' '`;)" sbks


connect_pg ()
{
    CONNSTR=$1;
    if [ -z "$1" ]; then
        if [ -f .env ]; then
            PGS=(`grep PG .env`);
        else
            PGS=();
        fi;
        if [ ${#PGS[@]} == 0 ]; then
            echo "input connstr:";
            read CONNSTR;
        else
            if [ ${#PGS[@]} == 1 ]; then
                CONNSTR=${PGS[0]};
            else
                echo "which db?";
                for X in $(seq ${#PGS[@]});
                do
                    echo "[$X] - ${PGS[$X-1]}";
                done;
                read IDX;
                CONNSTR=${PGS[$IDX-1]};
            fi;
        fi;
    fi;
    printf "\n\n=====================================================================";
    printf "\nUsing:";
    printf "\n\e[1m\e[93m${CONNSTR}\e[0m";
    printf "\n=====================================================================\n\n";
    CONNSTR=${CONNSTR#*//};
    USER=${CONNSTR%%:*};
    CONNSTR=${CONNSTR#*:};
    PASS=${CONNSTR%%@*};
    CONNSTR=${CONNSTR#*@};
    if [[ $CONNSTR == *":"* ]]; then
        HOST=${CONNSTR%:*};
        CONNSTR=${CONNSTR#*:};
        PORT=${CONNSTR%/*};
        CONNSTR=${CONNSTR##*/};
    else
        HOST=${CONNSTR%/*};
        CONNSTR=${CONNSTR##*/};
    fi
    DB=${CONNSTR%\?*};
    PGPASSWORD=$PASS psql -h $HOST -U $USER $DB
}


# PFM
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias mon_vga='xrandr --output DP-2 --mode 1920x1080 --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off --output eDP-1 --mode 1600x900 --below DP-2'
alias mon_vga_only='xrandr --output DP-2 --mode 1920x1080 --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off --output eDP-1 --off'
alias mon_hdmi='xrandr --output HDMI-1 --mode 1920x1080 --output DP-1 --off --output DP-2 --off --output HDMI-2 --off --output eDP-1 --mode 1600x900 --below HDMI-1'
alias mon_hdmi_only='xrandr --output HDMI-1 --mode 1920x1080 --output DP-1 --off --output DP-2 --off --output HDMI-2 --off --output eDP-1 --off'
alias mon_laptop='xrandr --output DP-1 --off --output DP-2 --off --output HDMI-1 --off --output HDMI-2 --off --output eDP-1 --mode 1920x1080'
alias mon_dp_only='xrandr --output DP-1 --mode 1920x1200 --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off --output eDP-1 --off'


alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias kdo='dig +short -x'
alias pmsuspend='sudo pm-suspend'

alias killchrome='ps ux | grep '\''[C]hrome Helper --type=renderer'\'' | grep -v extension-process | awk '\''{print $2}'\'''

setxkbmap -layout vok_sk

export PROMPT_COMMAND='
echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"
'
export HISTCONTROL=ignoredups:erasedups:ignoreboth
export HISTSIZE=100000
export HISTFILESIZE=2000000
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export NODE_HEAPDUMP_OPTIONS=nosignal
export EDITOR=vim
export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre

function odjebat() {
    ssh-keygen -R $1 && ssh -o 'StrictHostKeyChecking=no' $1
}


GRC=grc
alias colourify="$GRC -es --colour=auto"
alias configure='colourify ./configure'
alias diff='colourify diff'
alias make='colourify make'
alias gcc='colourify gcc'
alias g++='colourify g++'
alias as='colourify as'
alias gas='colourify gas'
alias ld='colourify ld'
alias netstat='colourify netstat'
alias ping='colourify ping'
alias traceroute='colourify /usr/sbin/traceroute'
alias head='colourify head'
alias tail='colourify tail'
alias dig='colourify dig'
alias mount='colourify mount'
alias ps='colourify ps'
#alias mtr='colourify mtr --curses'
alias mtr='mtr --curses'
alias df='colourify df'

alias pendolino="curl -H 'Host: www.imbord.info' 'https://10.0.1.254/hotspot/hotspot.cgi?method=login&username=lab&password=CAEN&realm=lab' -kIL"

export MARATONEC_TOKEN=9uM7PBqy8yJJsKeUNMzP
export CHROMIUM_FLAGS=--enable-remote-extensions
