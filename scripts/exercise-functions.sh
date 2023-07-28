copy-rsc() {
  local resourcePath="$1" path="$2" subDir="$3"

  local rscPath="../resources"
  local localDir="./"

  if [ -z "$subDir" ]; then
    cp -rf "$rscPath/$resourcePath" "$localDir/$path"
  else
    mkdir -p "$subDir"
    cp -rf "$rscPath/$resourcePath" "$localDir/$subDir/$path"
  fi
}

copy-to-src() {
  local resourcePath="$1" path="$2"

  copy-rsc "$resourcePath" "$path" "src"
}

copy-to-test() {
  local resourcePath="$1" path="$2"

  copy-rsc "$resourcePath" "$path" "test"
}

in-src() {
  cd ./src || exit
  "$@"
  cd ../ || exit
}

replace-in-file() {
  local file="$1" searchStr="$2" replaceStr="$3"

  sed -i '' "s/$searchStr/$replaceStr/" "$file"
}

insert-line-after-in-file() {
  local file="$1" line="$2" newLine="$3"

  sed -i -e "/^$line$/a"$'\\\n'"$newLine"$'\n' "$file"
}

prepend-line-to-file() {
  local file="$1" newLine="$2"

  sed -i '' '1s/^/'"$newLine"'\n/' "$file"
}

extract-lines-to-new-file() {
  local file="$1" fromLine="$2" toLine="$3" newFile="$4"

  sed -n "${fromLine},${toLine}p" "$file" >"$newFile"
}

remove-lines-in-file() {
  local file="$1" fromLine="$2" toLine="$3"

  if [ -z "$toLine" ]; then
    sed -i '' "${fromLine}d" "$file"
  else
    sed -i '' "${fromLine},${toLine}d" "$file"
  fi
}
