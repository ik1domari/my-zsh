# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-.]=** r:|=**'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=5
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/tom/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install

# Key bindings
# Print current key bindings: bindkey
# List available key bindings: bindkey -l
# Interactively show pressed key when pressing any keys
bindkey "^[[H" beginning-of-line # HOME
bindkey "^[[F" end-of-line # END
bindkey "^[[3~" delete-char # DEL
bindkey "^[[3;5~" delete-word # CTRL+DEL - delete a whole word after cursor
bindkey "^H" backward-delete-word # CTRL+BACKSPACE - delete a whole word before cursor
bindkey "^[[1;5C" forward-word # CTRL+ARROW_RIGHT - move cursor forward one word
bindkey "^[[1;5D" backward-word # CTRL+ARROW_LEFT - move cursor backward one word
bindkey "^Z" undo # CTRL+Z
bindkey "^Y" redo # CTRL+Y

# Aliases
alias md="mkdir -p"
alias rd="rm -rf"
alias pn="pnpm"
alias ......="cd ../../.."
alias t="tere --filter-search"
alias hib="systemctl hibernate"
alias glog="git log --all --decorate --graph --abbrev-commit --format='%C(bold yellow)%h%d%C(reset) - %C(white)%s%C(reset)%n          %C(bold blue)%ar (%ai)%C(reset) %C(bold dim green)%an%C(reset)'"
alias adog="git log --all --decorate --oneline --graph"
alias ddc='f() { sudo ddccontrol -r 0x10 -w $1 dev:/dev/i2c-3 };f'
alias histctx="grep -n '' ~/.histfile | fzf --delimiter : --preview 'bat --style=numbers --color=always --highlight-line {1} ~/.histfile' --preview-window +{1}-/2"

# Env Exports
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-match_002dwords_002dby_002dstyle
# Define how to match "words"; default mode is "normal" (alphanumerical + WORDCHARS)
# Default WORDCHARS are *?_-.[]~=/&;!#$%^(){}<>
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
# Set the default editor for sudoedit or sudo -e
export VISUAL=micro
export EDITOR="$VISUAL"
# fzf default find command (can also use ag (silver surfer), rg (ripgrep), etc.)
export FZF_DEFAULT_COMMAND='find . \! \( -type d -path ./.git -prune \) \! -type d \! -name '\''*.tags'\'' -printf '\''%P\n'\'

# pnpm
export PNPM_HOME="/home/timur/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:/home/timur/.dotnet/tools"


# https://github.com/mgunyho/tere
tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

# If the internal history needs to be trimmed to add the current command line, setting this
# option will cause the oldest history event that has a duplicate to be lost before losing a
# unique event from the list. You should be sure to set the value of HISTSIZE to a larger
# number than SAVEHIST in order to give you some room for the duplicated events, otherwise
# this option will behave just like HIST_IGNORE_ALL_DUPS once the history fills up with unique
# events.
setopt HIST_EXPIRE_DUPS_FIRST
# When searching for history entries in the line editor, do not display duplicates of a line
# previously found, even if the duplicates are not contiguous.
setopt HIST_FIND_NO_DUPS
# If a new command line being added to the history list duplicates an older one, the older
# command is removed from the list (even if it is not the previous event).
setopt HIST_IGNORE_ALL_DUPS
# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt HIST_IGNORE_DUPS
# Remove command lines from the history list when the first character on the line is a space,
# or when one of the expanded aliases contains a leading space. Only normal aliases (not
# global or suffix aliases) have this behaviour. Note that the command lingers in the internal
# history until the next command is entered before it vanishes, allowing you to briefly reuse
# or edit the line. If you want to make it vanish right away without entering another command,
# type a space and press return.
setopt HIST_IGNORE_SPACE
# When writing out the history file, older commands that duplicate newer ones are omitted.
setopt HIST_SAVE_NO_DUPS
# This option works like APPEND_HISTORY except that new history lines are added to the $HISTFILE
# incrementally (as soon as they are entered), rather than waiting until the shell exits.
setopt INC_APPEND_HISTORY

# Git status in prompt with the $(gitprompt) expansion
source ~/my-zsh/zsh-scripts-and-plugins/scripts/git-prompt.zsh
ZSH_THEME_GIT_PROMPT_PREFIX=" ("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_TAG="%{$fg_bold[white]%}"

# Customizing the prompt
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# Either show hostname in the prompt "[tom@v330:~]" or not [tom:~]:
# PROMPT='%B%F{cyan}[%n:%f%F{blue}%(4~|../|)%3~%f%b$(gitprompt)%B%F{magenta}]$ %f%b' # without hostname
PROMPT='%B%F{cyan}[%n@%m:%f%F{blue}%(4~|../|)%3~%f%b$(gitprompt)%B%F{cyan}]$ %f%b' # with hostname

RPROMPT='%B%F{red}%(0?||Exit code: %?)%f%b'

# CTRL+ARROW_RIGHT   - partially accept suggestion up to the point that the cursor moves to
# ARROW_RIGHT or END - accept suggestion and replace contents of the command line buffer with the suggestion
source ~/my-zsh/zsh-scripts-and-plugins/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# CTRL+T - paste the selected files and directories onto the command-line
# # CTRL+R - paste the selected command from history onto the command-line
# ALT+C  - cd into the selected directory
source ~/my-zsh/zsh-scripts-and-plugins/fzf/key-bindings.zsh
# Type ** and hit tab (eg. with the cd command; works with directories, files, process IDs, hostnames, environment variables)
source ~/my-zsh/zsh-scripts-and-plugins/fzf/completion.zsh

# Sift through history for previous commands matching everything up to current cursor position.
# Moves the cursor to the end of line after each match.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # ARROW_UP
bindkey "^[[B" down-line-or-beginning-search # ARROW_DOWN
# -> This only works for prefixes. If you want to match any substring in the history
#    then https://github.com/zsh-users/zsh-history-substring-search might be interesting

# Must go last (see https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file)
source ~/my-zsh/zsh-scripts-and-plugins/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH=/home/timur/development/flutter/bin:$PATH
