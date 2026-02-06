#!/bin/bash

SESSION_DIR="$HOME/.config/kitty/sessions"

echo "Kitty Sessions (Available): "
ls "$SESSION_DIR/" | sed 's/\.conf//'
echo ""

SESSION_NAME=$(ls "$SESSION_DIR" | sed 's/\.conf//' | fzf --height 40% --reverse)
SESSION_FILE="$SESSION_DIR/$SESSION_NAME.conf"

CURRENT_WINDOW_ID=$KITTY_WINDOW_ID
echo $CURRENT_WINDOW_ID

if [ -f "$SESSION_FILE" ]; then
    (setsid nohup kitty --session "$SESSION_FILE" >/dev/null 2>&1 &)
    kitty @ close-window --match id:$CURRENT_WINDOW_ID
else
    echo "Session '$SESSION_NAME' not found in $SESSION_DIR"
fi
