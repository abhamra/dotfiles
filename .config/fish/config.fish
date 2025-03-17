. ~/.config/fish/aliases.fish
fish_config theme choose "Rosé Pine"

set -g man_blink -o eb6f92    # love (soft red)
set -g man_bold -o 31748f     # pine (blue-green)
set -g man_standout -b 191724 908caa  # base background, subtle foreground
set -g man_underline -u 9ccfd8  # foam (cyan-like)

function fish_prompt
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_use_informative_chars false
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_char_stateseparator ' '
    set -g __fish_git_prompt_color brblack
    echo -sn (set_color magenta) $USER (set_color brblack) '@' (set_color green) (prompt_hostname) ' ' (set_color cyan) (prompt_pwd) (fish_git_prompt)
    if fish_is_root_user
        echo -n (set_color red --bold)' $ '
    else
        echo -n (set_color blue)' > '
    end
    set_color normal
end

function fish_right_prompt
    set -l last_status $status
    test $last_status -ne 0
    and echo (set_color red --bold)"[$last_status]"(set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
