# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

function fish_prompt
  set last_status $status
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal
  printf '%s ' (__fish_git_prompt)
  set_color normal
end

# fish calls command-not-found with an additional argument,
# which is not supported by NixOS command-not-found script.
# This function strips that argument.
function command-not-found
  /run/current-system/sw/bin/command-not-found $argv[2]
end

eval (hub alias -s)

# git aliases
alias gst="git status -sb"
alias gp="git push"
alias gup="git pull"
alias glo="git log --oneline --color --decorate"
alias gd="git diff"
alias gcam="git commit -am"