#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" || exit $?

# --- Discover exercises ---

folders=()
numbers=()
titles=()

for dir in "$REPO_ROOT_DIR"/[0-9][0-9][0-9]-*/; do
  [[ -d "$dir" ]] || continue

  local_name="$(basename "$dir")"
  num="${local_name:0:3}"

  title=""
  readme="$dir/README.md"
  if [[ -f "$readme" ]]; then
    read -r line < "$readme" || true
    title="${line#\# }"
  fi
  if [[ -z "$title" ]]; then
    title="$local_name"
  fi

  folders+=("$dir")
  numbers+=("$num")
  titles+=("$title")
done

if [[ ${#folders[@]} -eq 0 ]]; then
  echo "No exercises found." >&2
  exit 1
fi

# --- Build display lines ---
# Each exercise gets an index into the exercises arrays.
# We also track "display lines" which include category headers (non-selectable).

display_lines=()     # text to show for each line
display_indices=()   # index into folders/numbers/titles, or -1 for headers/blanks

prev_category=""
for i in "${!folders[@]}"; do
  category="${numbers[$i]:0:1}"
  if [[ "$category" != "$prev_category" ]]; then
    if [[ -n "$prev_category" ]]; then
      display_lines+=("")
      display_indices+=("-1")
    fi
    case "$category" in
      1) display_lines+=("# Local-only Repository") ;;
      2) display_lines+=("# Repository w/ Remote") ;;
      3) display_lines+=("# Advanced Git Exercises") ;;
      *) display_lines+=("# Unknown") ;;
    esac
    display_indices+=("-1")
    prev_category="$category"
  fi
  clean_title="${titles[$i]}"
  clean_title="${clean_title#${numbers[$i]}}"
  clean_title="${clean_title# }"
  clean_title="${clean_title#- }"
  display_lines+=("∟ ${numbers[$i]} ${clean_title}")
  display_indices+=("$i")
done

# --- Interactive menu ---

total_lines=${#display_lines[@]}

# Find first selectable line
selected=0
for (( j=0; j<total_lines; j++ )); do
  if [[ "${display_indices[$j]}" != "-1" ]]; then
    selected=$j
    break
  fi
done

number_buffer=""

cursor_up() {
  printf '\033[%dA' "$1"
}

render_menu() {
  for (( j=0; j<total_lines; j++ )); do
    if [[ $j -eq $selected && "${display_indices[$j]}" != "-1" ]]; then
      printf '\033[7m%s\033[0m\n' "${display_lines[$j]}"
    else
      printf '%s\n' "${display_lines[$j]}"
    fi
  done
  echo ""
  # Prompt line
  if [[ -n "$number_buffer" ]]; then
    printf '🔢 Enter exercise number: %s' "$number_buffer"
  else
    printf '🔢 Select exercise (↑/↓ + Enter, or type number) · Press q or ESC to exit'
  fi
}

redraw_menu() {
  cursor_up $((total_lines + 1))
  printf '\r\033[J'
  render_menu
}

move_selection() {
  local dir=$1
  local new_sel=$selected
  while true; do
    new_sel=$(( new_sel + dir ))
    if [[ $new_sel -lt 0 || $new_sel -ge $total_lines ]]; then
      return # hit boundary, don't move
    fi
    if [[ "${display_indices[$new_sel]}" != "-1" ]]; then
      selected=$new_sel
      return
    fi
  done
}

lookup_number() {
  local num="$1"
  local matches=()
  for i in "${!numbers[@]}"; do
    if [[ "${numbers[$i]}" == "$num" ]]; then
      matches+=("$i")
    fi
  done
  if [[ ${#matches[@]} -eq 1 ]]; then
    echo "${matches[0]}"
  elif [[ ${#matches[@]} -gt 1 ]]; then
    # disambiguation needed
    echo "multiple:${matches[*]}"
  else
    echo "-1"
  fi
}

# --- Save terminal state and run menu ---

cleanup() {
  printf '\033[?25h'
  if [[ -n "${saved_stty:-}" ]]; then
    stty "$saved_stty" 2>/dev/null || true
  fi
}
trap cleanup EXIT

saved_stty="$(stty -g 2>/dev/null || true)"

printf '\033[?25l'

echo "️👩‍💻👨‍💻 Git-Kata - Clean History"
echo ""

render_menu

# --- Input loop ---
while true; do
  # Read a single character (raw mode)
  IFS= read -rsn1 key || true

  case "$key" in
    $'\x1b')
      # Escape sequence — read next two chars
      IFS= read -rsn1 -t 0.1 seq1 || true
      IFS= read -rsn1 -t 0.1 seq2 || true
      if [[ "$seq1" == "[" ]]; then
        case "$seq2" in
          A) # Up arrow
            number_buffer=""
            move_selection -1
            redraw_menu
            ;;
          B) # Down arrow
            number_buffer=""
            move_selection 1
            redraw_menu
            ;;
        esac
      elif [[ -z "$seq1" ]]; then
        # Bare ESC pressed
        printf '\n\n'
        exit 0
      fi
      ;;
    "")
      # Enter key
      if [[ -n "$number_buffer" ]]; then
        result="$(lookup_number "$number_buffer")"
        if [[ "$result" == "-1" ]]; then
          old_buffer="$number_buffer"
          number_buffer=""
          redraw_menu
          printf '\n\033[31mNo exercise found with number %s\033[0m' "$old_buffer"
          sleep 1
          redraw_menu
        elif [[ "$result" == multiple:* ]]; then
          # Disambiguation
          match_indices=(${result#multiple:})
          printf '\n\nMultiple exercises match number %s:\n' "$number_buffer"
          for idx in "${match_indices[@]}"; do
            printf '  %s\n' "${titles[$idx]}"
          done
          printf 'Please use arrow keys to select the specific exercise.\n'
          number_buffer=""
          sleep 2
          redraw_menu
        else
          # Single match — select it
          exercise_idx="$result"
          break
        fi
      else
        # Enter on highlighted item
        if [[ "${display_indices[$selected]}" != "-1" ]]; then
          exercise_idx="${display_indices[$selected]}"
          break
        fi
      fi
      ;;
    [0-9])
      number_buffer+="$key"
      redraw_menu
      # Auto-select if 3 digits entered
      if [[ ${#number_buffer} -ge 3 ]]; then
        result="$(lookup_number "$number_buffer")"
        if [[ "$result" == "-1" ]]; then
          old_buffer="$number_buffer"
          number_buffer=""
          redraw_menu
          printf '\n\033[31mNo exercise found with number %s\033[0m' "$old_buffer"
          sleep 1
          redraw_menu
        elif [[ "$result" == multiple:* ]]; then
          match_indices=(${result#multiple:})
          printf '\n\nMultiple exercises match number %s:\n' "$number_buffer"
          for idx in "${match_indices[@]}"; do
            printf '  %s\n' "${titles[$idx]}"
          done
          printf 'Please use arrow keys to select the specific exercise.\n'
          number_buffer=""
          sleep 2
          redraw_menu
        else
          exercise_idx="$result"
          break
        fi
      fi
      ;;
    q|Q)
      printf '\n\n'
      exit 0
      ;;
    *)
      # Ignore other keys
      ;;
  esac
done

# --- Clean up display ---
printf '\r\033[K'

printf '\033[?25h'

# Restore terminal for normal input
if [[ -n "${saved_stty:-}" ]]; then
  stty "$saved_stty" 2>/dev/null || true
fi

selected_folder="${folders[$exercise_idx]}"
echo "👩‍💻👨‍💻 Exercise '${titles[$exercise_idx]}' selected"

# --- Interactive folder name prompt ---

echo ""
folder_suffix=""
prompt_prefix=$'🔡 Enter exercise folder name: '

redraw_folder_prompt() {
  printf '\r\033[K%s' "$prompt_prefix"
  if [[ -n "$folder_suffix" ]]; then
    printf '📁 exercise-%s' "$folder_suffix"
  else
    printf '📁 exercise'
  fi
}

redraw_folder_prompt

while true; do
  IFS= read -rsn1 char || true
  case "$char" in
    "")  # Enter
      break
      ;;
    $'\x1b')  # ESC
      IFS= read -rsn1 -t 0.1 seq1 || true
      if [[ -z "$seq1" ]]; then
        # Bare ESC pressed — exit cleanly
        printf '\n\n'
        exit 0
      else
        # Consume any trailing escape sequence characters
        IFS= read -rsn1 -t 0.1 seq2 || true
      fi
      ;;
    $'\x7f'|$'\x08')  # Backspace/Delete
      if [[ -n "$folder_suffix" ]]; then
        folder_suffix="${folder_suffix%?}"
        redraw_folder_prompt
      fi
      ;;
    [[:print:]])  # Printable character
      folder_suffix+="$char"
      redraw_folder_prompt
      ;;
  esac
done

# --- Clean up display ---
printf '\r\033[K'

# --- Execute exercise's init.sh ---
if [[ -n "$folder_suffix" ]]; then
  exec bash "${selected_folder}init.sh" "exercise-${folder_suffix}"
else
  exec bash "${selected_folder}init.sh"
fi
