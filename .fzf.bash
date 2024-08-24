# Setup fzf
# ---------
if [[ ! "$PATH" == */home/arjunbhamra/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/arjunbhamra/.fzf/bin"
fi

eval "$(fzf --bash)"
