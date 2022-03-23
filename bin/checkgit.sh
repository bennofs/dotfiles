#!/usr/bin/env bash
set -eu

blue='\e[34m'
reset='\e[0m'
bold='\e[1m'
green='\e[32m'
red='\e[31m'
yellow='\e[33m'

function repo_is_clean {
  mv -f .git/info/exclude .git/info/exclude.bak 2> /dev/null
  local ret=0
  if ! git fetch --all; then
    ret=1
    echo -e "${red}fetch failed$reset"
  fi
  for branch in $(git for-each-ref --format='%(refname:short)' refs/heads/); do
    if ! git merge-base --is-ancestor "$branch" "$(git branch -r --format '%(objectname)' --contains "$branch" | head -n1)" 2> /dev/null; then
      ret=1
      echo -e "$red$branch:$reset remote not up-to-date"
      continue
    fi
  done
  if ! (git -c core.fileMode=false diff --diff-filter=dt -q --exit-code && git -c core.fileMode=false diff --diff-filter=dt --cached --exit-code &> /dev/null); then
    ret=1
    echo -e "${red}not clean$reset"
    git status
  fi
  if ! (git -c core.fileMode=false ls-files --exclude-standard --other --directory --no-empty-directory | sed q1) > /dev/null; then
    ret=1
    echo -e "${red}there are untracked files$reset"
    git status
  fi
  mv -f .git/info/exclude.bak .git/info/exclude 2> /dev/null
  return $ret
}

clean=""
repos=("$@")
if [ $# -eq 0 ]; then
  repos=(*/)
fi
for i in "${repos[@]}"; do
  pushd "$i" > /dev/null
  if [ ! -d .git ]; then
    echo -e "$bold$yellow- $i - not a git repo$reset"
  else
    echo -e "$bold+ $red$i$reset"
    if repo_is_clean; then
      clean="$i $clean"
    fi
  fi
  popd > /dev/null
done

echo ":: result"
echo "$clean"

