# open a new tmux window with yazi for the phone

function :phone() {
  local script_dir="${${(%):-%x}:A:h}"
  local mtp_script="$script_dir/src/mtp-mnt.sh"
  
  if [[ -n $TMUX ]]; then
    tmux new-window -n phone "$mtp_script"
  else
"$mtp_script"
  fi
}

# open a new tmux window with yazi for the usb

function :usb() {
  local script_dir="${${(%):-%x}:A:h}"
  local usb_script="$script_dir/src/usb-mnt.sh"

  if [[ -n $TMUX ]]; then
    tmux new-window -n usb "$usb_script"
  else
"$usb_script"
  fi
}
