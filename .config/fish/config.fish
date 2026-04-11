. ~/.config/fish/aliases.fish
fish_config theme choose "Rosé Pine"

function fish_greeting
    # fastfetch
    # fortune
end

# mlir-opt and llvm helpers
function lcmake
    set branch (git -C ~/personal/llvm-project rev-parse --abbrev-ref HEAD)
    set build_dir ~/personal/llvm-project/build-$branch
    
    sudo cmake -S ~/personal/llvm-project/llvm -B $build_dir -G Ninja \
        -DLLVM_ENABLE_PROJECTS="clang;mlir;lld" \
        -DLLVM_TARGETS_TO_BUILD="X86" \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DLLVM_ENABLE_ASSERTIONS=ON \
        -DLLVM_CCACHE_BUILD=ON \
        -DCMAKE_C_COMPILER=clang \
        -DCMAKE_CXX_COMPILER=clang++ \
        -DLLVM_USE_LINKER=ld $argv
end

function lninja
    set branch (git -C ~/personal/llvm-project rev-parse --abbrev-ref HEAD)
    sudo ninja -C ~/personal/llvm-project/build-$branch $argv
end

function pmlir-opt
    set branch (git -C ~/personal/llvm-project rev-parse --abbrev-ref HEAD)
    ~/personal/llvm-project/build-$branch/bin/mlir-opt $argv
end

fish_add_path -p /usr/local/bin
# for llvm21
# set -x LLVM_INSTALL_DIR ~/bin/llvm21
# set -x $PATH PATH "$LLVM_INSTALL_DIR/bin"
# set -x MLIR_DIR "$LLVM_INSTALL_DIR/lib/cmake/mlir/"

set -g man_blink -o eb6f92    # love (soft red)
set -g man_bold -o 31748f     # pine (blue-green)
set -g man_standout -b 191724 908caa  # base background, subtle foreground
set -g man_underline -u 9ccfd8  # foam (cyan-like)

set -Ux EDITOR nvim

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

# fzf configure bindings
fzf_configure_bindings --directory=\cf --variables=\e\cv

fish_add_path /home/arjunbhamra/.spicetify
fish_add_path $HOME/.cargo/bin
fish_add_path /home/arjunbhamra/.local/bin
zoxide init fish | source

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/arjunbhamra/.ghcup/bin $PATH # ghcup-env

thefuck --alias | source
