# Enable Vi mode
bindkey -v

# Use vim keys in the tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
