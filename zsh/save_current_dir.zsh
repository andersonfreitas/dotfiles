export CURRENT_PROJECT_PATH=$HOME/.current-project

function chpwd {
  echo $(pwd) >! $CURRENT_PROJECT_PATH
}

current() {
  if [[ -f $CURRENT_PROJECT_PATH ]]; then
    cd "$(cat $CURRENT_PROJECT_PATH)"
  fi
}

current

