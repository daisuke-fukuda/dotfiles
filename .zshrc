export LANG=ja_JP.UTF-8
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# 1行表示
PROMPT="%~ %# "
# 2行表示
#PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
#%# "


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified


########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
	                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
setopt prompt_subst
autoload -Uz vcs_info
#zstyle ':vcs_info:*' formats '(%s)-[%b]'
#zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
#precmd () {
#    psvar=()
#    LANG=en_US.UTF-8 vcs_info
#    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
#}
#RPROMPT="%1(v|%F{green}%1v%f|)"

zstyle ':vcs_info:*' actionformats \
	    '%F{5}[%F{2}%b%F{7}:%F{6}%r%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats \
	    '%F{5}[%F{2}%b%F{7}:%F{6}%r%F{5}]%f'

zstyle ':vcs_info:*' enable git

vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
    }
RPROMPT=$'$(vcs_info_wrapper)'


#### git補完
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -U compinit
compinit -u




########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt magic_equal_subst
#setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt auto_menu
setopt extended_glob




# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '


alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
	alias -g C='| pbcopy'
fi

########################################
case ${OSTYPE} in
    darwin*)
           #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
	;;
esac




#from bash_profile
export PATH="/usr/local/Cellar/git/2.12.0:/opt/local/bin:/opt/local/lib/:/usr/local/bin:/usr/local/sbing:/usr/local/share/git-core/contrib/diff-highlight:$PATH"
export PATH="/Applications/Android/platform-tools/:/Applications/Android/tools/:$PATH"
export PATH="/opt/local/bin/:$PATH"
export PATH="/opt/local/apache2/bin/:$PATH"
export PATH="/opt/local/lib/php53/:$PATH"
export PATH="/Users/daisukefukuda/Library/Python/3.6/bin:$PATH"

export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

export ANDROID_HOME="/Users/daisukefukuda/Library/Android/sdk/"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

alias mysql_va='mysql -u root -h "192.168.33.10"'

export LSCOLORS=gxfxcxdxbxegedabagacad
#alias mysql="mysql --pager='less -S'"
alias ls='ls -G'
alias apache='sudo /opt/local/apache2/bin/apachectl'
alias his='history'
alias hisgrep='his 1000 | grep'
alias redis='redis-server /opt/local/etc/redis.conf &'
#vim
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#alias ssh="~/bin/safe_ssh $*"

#alias ssh="~/bin/ssh-host-color.sh $*"

#git
alias gco="git checkout"
alias gst="git status"
alias gci="git commit"
alias gs="git status"
alias gci="git commit"
alias gdi="git diff -b"
alias gbr="git branch"
alias gad="git add"
alias glg="git log"
alias glo="git log --date=short --pretty='format:%C(yellow)%h %C(green)%cd %C(blue)%an%C(red)%d %C(reset)%s'"
alias gti='git'
alias va="vagrant"
alias gcl="git branch --merged|egrep -v '\*|develop|main|master'|xargs git branch -d"
alias ll="ls -al"
#source ~/bash/git-prompt.sh
alias mysqldump=/usr/local/mysql/bin/mysqldump
#source ~/bash/git-completion.bash
#PS1="\h@\u:\W\$(__git_ps1) \$ "

# less のステータス行にファイル名と行数、いま何%かを表示するようにする。
export LESS='-X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
# これを設定しないと日本語がでない less もあるので一応入れておく。
export JLESSCHARSET=japanese-ujis


#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


function mkcd(){mkdir -p $1 && cd $1}
#source /Users/daisukefukuda/zsh_plugin/zaw/zaw.zsh

bindkey '^h' zaw-history


alias pjson="pbpaste | grep { | jq ."
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

setopt AUTO_CD
cdpath=(/Library/WebServer)

#unalias run-help
#autoload run-help
HELPDIR=/usr/local/share/zsh/help



alias halllist="cd /Library/WebServer/simplesougi-wordpress/src/wp-content/themes/mpt-wp-kakuyasusougi/functions/kakuyasusougi"


alias j="autojump"
  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
#







###### zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug "b4b4r07/enhancd", use:init.sh

zplug load


export PATH="/usr/local/opt/php@7.1/bin:$PATH"
export PATH="/usr/local/opt/php@7.1/sbin:$PATH"


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
export PATH=$HOME/.nodebrew/current/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/Applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/Applications/google-cloud-sdk/completion.zsh.inc'; fi


ssh-add --apple-load-keychain

export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
