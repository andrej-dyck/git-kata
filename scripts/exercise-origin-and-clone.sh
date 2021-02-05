exercise-origin-and-clone() {
  local exerciseDir="exercise"
  local originDir="${exerciseDir}-origin"

  local currentDir=${PWD##*/}

  if [ "$currentDir" != "$exerciseDir" ]; then
    echo "ERROR: not in exercise directory"
    return
  fi

  cd "../"

  # rename exercise dir to origin
  rm -rf "$originDir"
  mv "$exerciseDir" "$originDir"

  # clone origin
  git clone "./$originDir" "$exerciseDir"

  cd "$exerciseDir" || exit
}