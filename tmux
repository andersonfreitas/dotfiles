# mouse behavior
setw -g mode-mouse on
set -g mouse-select-pane on
set -g mouse-resize-pane on

set-option -g default-terminal screen-256color

# Enable native Mac OS X copy/paste
set-option -g default-command "/bin/bash -c 'which reattach-to-user-namespace >/dev/null && exec reattach-to-user-namespace $SHELL -l || exec $SHELL -l'"
