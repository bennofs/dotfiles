# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set fish_greeting ""

# Status Chars
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

# Prompt colors
set fish_color_host magenta

# Define prompt_hostname if it does not exist
if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname | string split '.')[1]
end
function fish_prompt
  set_color $fish_color_host
  printf '%s' $__fish_prompt_hostname
  set_color normal
  printf ':'

  set last_status $status
  if [ -n "$NIX_SHELL_PROJECT" ];
    set_color blue
    printf "$NIX_SHELL_PROJECT:"
  end

  if set -q VIRTUAL_ENV
    set_color blue
    printf (basename "$VIRTUAL_ENV")":"
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

# kitty aliases
alias di="kitty kitten diff"
alias sc="kitty-terminfo | ssh"
alias s="ssh"

# Colorful commands
function grc.wrap -a executable
  set executable $argv[1]
  
  if test (count $argv) -gt 1
    set arguments $argv[2..(count $argv)]
  else
    set arguments
  end

  env CLICOLOR_FORCE=1 grc -es --colour=auto $executable $arguments
end

function wrap_grc_exes
  set -l execs diff dig gcc g++ ifconfig ip make mount netstat ping ps ss traceroute
  for executable in $execs
    if type -q $executable
      function $executable --inherit-variable executable --wraps=$executable
        grc.wrap $executable $argv
      end
    end
  end
end
wrap_grc_exes

# key bindings
function fish_user_key_bindings
  # fzf config
  if functions -q fzf_key_bindings
    set FZF_ALT_C_COMMAND "find -H . -depth -mindepth 1 -type d \\( -not -readable -prune \\) -o -print"
    fzf_key_bindings
    bind \ek fzf-file-widget
    bind \eh fzf-history-widget
    bind \ej fzf-cd-widget
  end
end

# ensure MANPATH is set (fish and opam don't like empty manpath, leads to no manpages being found)
set -x MANPATH (env MANPATH= manpath)

if command -q -s direnv
  source (direnv hook fish | psub)
end

if command -q -s opam
  eval (opam env)
end

if command -q -s kitty
    kitty + complete setup fish | source
end

if command -q -s pyenv
  pyenv init - | source
end

source ~/.config/fish/asciii.fish

alias play 'wpa_cli -i wl disable 0; wpa_cli -i wl enable 25'
alias work 'wpa_cli -i wl enable 0; wpa_cli -i wl disable 25'
alias o xdg-open
alias prox "env SOCKS_AUTOADD_LANROUTES=no SOCKS4_SERVER=localhost:1888 socksify"

if test -f /opt/asdf-vm/asdf.fish
  source /opt/asdf-vm/asdf.fish
end
