###
# binding
######
set -g prefix C-a

# Last window
bind a last-window

# hjkl pane traversal
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind C-k send-keys -R \; clear-history # bare C-k is used in vim to type digraph

# Alt-arrow traversal
bind -n M-Left  select-pane -L
bind -n M-Down  select-pane -D
bind -n M-Up    select-pane -U
bind -n M-Right select-pane -R

# set window split
bind v split-window -h
bind b split-window

bind C command-prompt -p "Name of new window: " "new-window -n '%%'"

