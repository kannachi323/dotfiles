#!/bin/bash

export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

export FZF_ALT_C_OPTS="--preview 'ls -CF {} | head -50'"

bindkey '^F' fzf-cd-widget
