#!/bin/bash

name="$1"
filename=/tmp/"$1"

bspc_write_nodeid() {
    while true
    do
        flag=false
        for id in $(bspc query -d focused -N -n .floating.sticky.hidden)
        do
            bspc query --node $id -T | grep -q $name && { echo $id > $filename; flag=true; break; }
        done
        [[ "$flag" == "true" ]] && break
        sleep 0.1s
    done
}

hide_all_except_current(){
    for id in $(bspc query -d focused -N -n .floating.sticky.!hidden)
    do
        bspc query --node $id -T | grep -qv $name && bspc node $id --flag hidden=on
    done
}

toggle_hidden() {
    [ -e "$filename" ] || exit 1
    hide_all_except_current
    id=$(<$filename)
    bspc node $id --flag hidden -f
}

create_terminal(){
    local term_name=$1
    local cmd=$2

    kitty --class="$term_name" --hold -e bash -c "$cmd" &
}

if ! ps -ef | grep -q "[c]lass=$name"
then
    bspc rule -a "$name" --one-shot state=floating sticky=on hidden=on
    case "$name" in
        "gotop")
            create_terminal "gotop" gotop
            ;;
        "neomutt")
            create_terminal "neomutt" neomutt
            ;;
        "newsboat")
            create_terminal "newsboat" newsboat
            ;;
        "ranger")
            create_terminal "ranger" ranger
            ;;
        "terminal")
            create_terminal "terminal" $SHELL
            ;;
        "fetch")
            create_terminal "FloatTerm" "Term --fetch"
            ;;
        "cal3m")
            create_terminal "cal3m" "~/.local/bin/cal3m"
            ;;
        *)
            exit 1
    esac
    dunstify "Scratch: starting $name"
    bspc_write_nodeid
    toggle_hidden
else
    toggle_hidden
fi























# #!/bin/bash

# name="$1"
# filename=/tmp/"$1"

# bspc_write_nodeid() {
#     while true
#     do
#         flag=false
#         for id in $(bspc query -d focused -N -n .floating.sticky.hidden)
#         do
#             bspc query --node $id -T | grep -q $name && { echo $id > $filename; flag=true; break; }
#         done
#         [[ "$flag" == "true" ]] && break
#         sleep 0.1s
#     done
# }

# hide_all_except_current(){
#     for id in $(bspc query -d focused -N -n .floating.sticky.!hidden)
#     do
#         bspc query --node $id -T | grep -qv $name && bspc node $id --flag hidden=on
#     done
# }

# toggle_hidden() {
#     [ -e "$filename" ] || exit 1
#     hide_all_except_current
#     id=$(<$filename)
#     bspc node $id --flag hidden -f
# }

# create_terminal(){
#     local term_name=$1
#     local cmd=$2

#     case "$term_name" in
#         "gotop")
#             width=600
#             height=900
#             ;;
#         "neomutt")
#             width=960
#             height=720
#             ;;
#         "newsboat")
#             width=640
#             height=480
#             ;;
#         "ranger")
#             width=1300
#             height=500
#             ;;
#         "terminal")
#             width=1300
#             height=600
#             ;;
#         "cal3m")
#             width=550
#             height=280
#             ;;
#         *)
#             width=800
#             height=600
#             ;;
#     esac

#     kitty --class="$term_name" \
#           --hold \
#           -o initial_window_width=$width \
#           -o initial_window_height=$height \
#           -e bash -c "$cmd" &
#           # -e $cmd &
# }

# if ! ps -ef | grep -q "[c]lass=$name"
# then
#     bspc rule -a "$name" --one-shot state=floating sticky=on hidden=on
#     case "$name" in
#         "gotop")
#             create_terminal "gotop" gotop
#             ;;
#         "neomutt")
#             create_terminal "neomutt" neomutt
#             ;;
#         "newsboat")
#             create_terminal "newsboat" newsboat
#             ;;
#         "ranger")
#             create_terminal "ranger" ranger
#             ;;
#         "terminal")
#             create_terminal "terminal" $SHELL
#             ;;
#         "fetch")
#             create_terminal "FloatTerm" "Term --fetch"
#             ;;
#         "cal3m")
#             create_terminal "cal3m" "~/.local/bin/cal3m"
#             ;;
#         *)
#             exit 1
#     esac
#     dunstify "Scratch: starting $name"
#     bspc_write_nodeid
#     toggle_hidden
# else
#     toggle_hidden
# fi
