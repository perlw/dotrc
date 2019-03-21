#!/bin/zsh
notify() {
  notify-send "Screenshot taken" "$grim_filename" --icon=dialog-information
}

case $1 in
  partialclipboard)
    grim -g "$(slurp)" - | wl-copy && notify "Saved to clipboard"
    ;;
  partial)
    shot_date=$(date +%Y-%m-%d-%H%M%S)
    shot_rect=$(slurp)
    grim_filename=${shot_date}_$(echo $shot_rect | cut -d ' ' -f 2).png
    grim -g "$shot_rect" ~/ScreenGrabs/$grim_filename && notify $grim_filename
    ;;
  *)
    shot_date=$(date +%Y-%m-%d-%H%M%S)
    grim_filename=${shot_date}.png
    grim ~/ScreenGrabs/$grim_filename && notify "$grim_filename"
    ;;
esac
