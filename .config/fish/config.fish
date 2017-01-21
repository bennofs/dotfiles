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
  if [ -n "$NIX_SHELL_PROJECT" ];
    set_color blue
    printf "$NIX_SHELL_PROJECT:"
  end
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal
  set -l fs (stat --file-system --format="%T" (pwd))
  if contains "$fs" "btrfs" "ext4" "tmpfs" "proc" "sysfs" "ext2/ext3"
    printf '%s ' (__fish_git_prompt)
  else
    printf '⇄ '
  end
  set_color normal
end

function nix-git-channel
  cd $HOME/nixpkgs
  git checkout master # Only master contains the update-channel script
  ./maintainers/scripts/update-channel-branches.sh
  git checkout channels/remotes/nixos-unstable
end

# fish calls command-not-found with an additional argument,
# which is not supported by NixOS command-not-found script.
# This function strips that argument.
function command-not-found
  if command -s command-not-found;
    command command-not-found $argv[2]
  else
    echo "Fish: unknown command: '$argv[2]'"
  end
end

function make_completion --argument alias command
    complete -c $alias -xa "(
        set -l cmd (commandline -pc | sed -e 's/^ *\S\+ *//' );
        complete -C\"$command \$cmd\";
    )"
end

functions -c ls lss
alias ls="lss --group-directories-first"
eval (hub alias -s)

# git aliases
alias gst="git status -sb"
alias gp="git push"
alias gup="git pull"
alias glo="git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
alias gd="git diff"
alias gcam="git commit -am"
alias gc="git commit"
alias gco="git checkout"

make_completion gco "git checkout"
make_completion glo "git log"
make_completion gd "git diff"
make_completion gup "git pull"
make_completion gp "git push"
