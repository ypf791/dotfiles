###
# status bar
######
set -g message-style bg=colour235,fg=colour178

setw -g window-status-format " #I #W "
set -g status-style default,bg=colour235,fg=colour244

setw -g window-status-current-format " #I #W#F"
setw -g window-status-current-style none,bg=colour0,fg=colour178

set -g status-interval 1
#set -g status-justify centre # center align window list
set -g status-left '#[fg=colour34][#H] #[fg=black] '
set -g status-left-length 20
set -g status-right '#[fg=colour1,bright]#(uptime | cut -f 4-5 -d " " | cut -f 1 -d ",") #[fg=colour34,bg=default]%H:%M:%S %a#[default] #[fg=colour12]%Y-%m-%d'
set -g status-right-length 140

# Start numbering at 1
set -g base-index 1

