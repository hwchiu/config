# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:/Users/hwchiu/go/bin:/usr/local/opt/mysql-client/bin

# Path to your oh-my-zsh installation.
export ZSH="/Users/hwchiu/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git repo)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

function update_k8s_config {
    mv ~/.kube/configs ~/.kube/configs-`date +%Y-%m-%d-%H%M%S`
    mkdir ~/.kube/configs

    #staging rancher
    rancher server switch stage
    for c in $(rancher clusters ls --format  '{{.Cluster.Name}}'); do
        rancher cluster kf $c > ~/.kube/configs/$c
    done

    rancher server switch prod
    for c in $(rancher clusters ls --format  '{{.Cluster.Name}}' | grep -v rancher); do
        rancher cluster kf $c > ~/.kube/configs/$c
    done

    kubectl konfig merge ~/.kube/configs/* > ~/.kube/config
}

function aws_profile {
    RED='\033[0;31m'
    NC='\033[0m'
    [[ ! -z ${AWS_PROFILE} ]] && echo "${RED}AWS${NC}:$AWS_PROFILE"
}

function k8s_profile {
   BLUE='\033[0;34m'
   NC='\033[0m'
   echo -n "${BLUE}k8s-${NC}ctx:" && kubectl config current-context | tr '\n' ' '
   echo -n "ns:" && kubectl ns -c
}
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
PROMPT='$(aws_profile) $(k8s_profile)'"$PROMPT"
alias python='python3'
export LC_ALL=en_US.UTF-8

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

source <(kubectl completion zsh)
alias kc='kubectl'
alias onos='ssh -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$@"'
complete -F __start_kubectl kc
export GOPATH=/Users/hwchiu/onf
export PATH=$(go env GOPATH)/bin:$PATH
export GOOGLE_CREDENTIALS=/Users/hwchiu/hwchiu/gcp/credentials.json

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hwchiu/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hwchiu/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hwchiu/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hwchiu/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$PATH:/Users/hwchiu/Library/Python/3.8/bin/:/Users/hwchiu/Library/Python/2.7/bin/"


export NVM_DIR="/Users/hwchiu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="${PATH}:${HOME}/.krew/bin"
export GOOGLE_BACKEND_CREDENTIALS=/Users/hwchiu/onf/credential/gcp.json; export GOOGLE_CREDENTIALS="/Users/hwchiu/onf/credential/gcp_provider.json"

alias vim='nvim'
alias vi='nvim'
source ~/python_env/bin/activate
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
