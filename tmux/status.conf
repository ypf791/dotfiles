###
# status bar
######
set -g status-attr default

set -g message-bg colour235 #base02
set -g message-fg colour178 #yellow

setw -g window-status-format " #I #W "
set -g status-bg colour235 #base02
set -g status-fg colour244 #gray
set -g status-attr default

setw -g window-status-current-format " #I #W#F"
setw -g window-status-current-attr none
setw -g window-status-current-bg colour0
setw -g window-status-current-fg colour178 #yellow

set -g status-interval 1
#set -g status-justify centre # center align window list
set -g status-left '#[fg=colour34][#H] #[fg=black] '
set -g status-left-length 20
set -g status-right '#[fg=green,bg=default,bright]#(tmux-mem-cpu-load 1) #[fg=colour1]#(uptime | cut -f 4-5 -d " " | cut -f 1 -d ",") up #[fg=colour34,bg=default]%H:%M:%S %a#[default] #[fg=colour12]%Y-%m-%d'
set -g status-right-length 140

# Start numbering at 1
set -g base-index 1

