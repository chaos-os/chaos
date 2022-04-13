#!/usr/bin/bash

gm="https://meet.google.com"


VAR1=$(printf '%s\n' "DAA" "DMS" "SS L/TH" "SS TUT" "WT TH" "WT L" "WT TUT" "New Meet"| dmenu -i -l 10 -p 'Google meet')

if [[ "$VAR1" == "DAA" ]]; then
	brave-browser $gm/"pse-gyeq-bds"
elif [[ "$VAR1" == "DMS" ]]; then
	brave-browser $gm/"apr-ijmy-vni"
elif [[ "$VAR1" == "SS L/TH" ]]; then
	brave-browser $gm/"pyn-mxzy-hqo"
elif [[ "$VAR1" == "SS TUT" ]]; then
	brave-browser $gm/"ben-ovsi-rkm"
elif [[ "$VAR1" == "WT TH" ]]; then
	brave-browser $gm/"bxd-gvjn-cea"
elif [[ "$VAR1" == "WT L" ]]; then
	brave-browser $gm/"vps-tifb-yhk"
elif [[ "$VAR1" == "WT TUT" ]]; then
	brave-browser $gm/"ben-ovsi-rkm"
elif [[ "$VAR1" == "New Meet" ]]; then
	VAR=$(echo ''| dmenu -p "Code: ")
	brave-browser $gm/$VAR
fi
