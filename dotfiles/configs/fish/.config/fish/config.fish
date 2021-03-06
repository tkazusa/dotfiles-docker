export XDG_CONFIG_HOME=$HOME/.config
export TERM=xterm-256color

set --universal -x GOPATH $HOME/go
set -x PATH /usr/local/go/bin $GOPATH/bin $HOME/.loval/bin $PATH  
set -x PATH $HOME/.local/bin $HOME/.cargo/bin $PATH
set -x PATH $HOME/.awscli/aws $PATH
set -U FZF_LEGACY_KEYBINDINGS 0
set -g fisher_path $HOME/dotfiles/.config/fish

alias v 'nvim'
alias ll 'ls -laGn'
alias cu 'cd ../'
alias ps 'ps -aux'
alias ga 'git add'
alias gc 'git commit -m'
alias gs 'git status'
alias gp 'git push'
alias gd 'git add .;git commit -m "mod";git push origin master'
alias pc 'peco'
alias jl 'jupyter lab --allow-root'
alias python 'python3'
alias pip 'pip3'

function fish_prompt
    set pwd (set_color green)(prompt_pwd)
    set p (set_color normal) "> "
    echo $pwd $p
end

# Git
set git_dirty_color red
set git_not_dirty_color green


function parse_git_branch
    set -l branch (git branch 2> /dev/null | grep -e '\*' | sed 's/^..\(.*\)/\1/')
    set -l git_diff (git diff)

    if test -n "$git_diff"
      echo (set_color $git_dirty_color)$branch(set_color normal)
    else
      echo (set_color $git_not_dirty_color)$branch(set_color normal)
    end
end

function cd
    builtin cd $argv; and ll
end


function fish_right_prompt
  set -l git_dir (git rev-parse --git-dir 2> /dev/null) 
  if test -n "$git_dir"
    echo [(parse_git_branch)]
  end
end


# For pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

# For poetry
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source
