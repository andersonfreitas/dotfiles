source ~/bin/dotfiles/bash/aliases.bash

function colours() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

function colorcube() {
  for red in {0..6} ; do
    for green in {0..6} ; do
      for blue in {0..6} ; do
         printf "\x1b]4;%d;rgb:%2.2x/%2.2x/%2.2x\x1b\\" $((16 + (red * 36) + (green * 6) + blue)) $((red ? (red * 40 + 55) : 0)) $((green ? (green * 40 + 55) : 0)) $((blue ? (blue * 40 + 55) : 0))
      done
    done
  done
}

function colorcube2() {
  for green in {0..6} ; do
    for red in {0..6} ; do
      for blue in {0..6} ; do
        color=$((16 + (red * 36) + (green * 6) + blue))
        printf "\x1b[48;5;${color}m  "
      done
      printf "\x1b[0m "
    done
    printf "\n"
  done
}

