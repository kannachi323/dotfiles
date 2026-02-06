#!/bin/bash


export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# This adds the "ls" preview to both shortcuts
export FZF_ALT_C_OPTS="--preview 'ls -CF {} | head -50'"

bind '"\C-f": "\ec"'
