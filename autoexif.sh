#!/bin/bash
##############################
##        Auto Exif         ##
##############################
##  Created By Sir Cryptic  ##
############################## 
##  Developer Sir Cryptic   ## 
##############################
##       Greetz Mobly       ##
##       Greetz R!ff        ##
##       Greetz Double A    ##
##       Greetz lucci       ##
##############################
############################## 
##      Developed On        ##
##        BackBox           ##
##############################

if [ -f /etc/bash_completion.d/readline ]; then
    . /etc/bash_completion.d/readline
fi

HISTFILE="$HOME/.bash_history"
history -a "$HISTFILE"

# enable arrow key support
if [[ $- == *i* ]]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[C": forward-char'
    bind '"\e[D": backward-char'
fi
history -r
history -a
history -w

while true
do
clear
#COLOUR
red='\e[1;31m'
yellow='\e[0;33m'
Blue='\e[1;34m'
red='\e[1;31m'
green='\e[1;32m'
yellow='\e[1;33m'
magenta='\e[1;35m'
cyan='\e[1;36m'
reset='\e[0m'
title="Auto~Exif"
echo -e '\033]2;'$title'\007'

 echo -e "                ▌║█║▌│║▌│║▌║▌█║AutoExif▌│║▌║▌│║║▌█║▌║█"
 echo -e '\e[0;33m┌───────────────────────────────────────────────────────────────────┐
\e[1;31m│Exif Tool AutoMated For Easy Conveinience\e[3;34m Created by "Sir Cryptic"\e[0m\e[1;31m │
\e[0;33m├───────────────────────────────────────────────────────────────────┤
\e[0m\e[1;31m│You Must Install Dependencies For This Script To Work Properly     │\e[3;39m
\e[0;33m└───────────────────────────────────────────────────────────────────┘\e[0m
┌───────────────────────────────────────────────────────────────────┐
│(1) Read Image MetaData (Basic)                                    │
│(2) Read Image MetaData (Expert)                                   │
│(3) Read Image MetaData (From Website)                             │
│(4) Wipe Data From Image (Except JFIF Groups)                      │
│(5) Wipe All GPS Data From Image                                   │
│(6) Wipe All MetaData From Image (Adds Comment Back In)            │
│(7) Extract GPS from AVCH video                                    │
│(8) Extract Info From Thumbnail                                    │
│(9) Wipe Photoshop MetaData                                        │
│(h) Help                                                           │
│(i) Install Dependencies & Script                                  │
│(c) Contact Information                                            │
├───────────────────────────────────────────────────────────────────┤
│(q) Press q/Q to quit                                              │
└───────────────────────────────────────────────────────────────────┘
'

echo -e $Blue" ┌─["$red"Auto$Blue]──[$red~$Blue]─["$yellow"Exif$Blue]:"
read -n 1 -r -e -p" └─────► " choice
  case $choice in
    1)
clear
usage="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│          usage example: ${magenta}/home/username/Pictures/lulz.png ${Blue}         │
├───────────────────────────────────────────────────────────────────┘${reset}"
extracting_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                          Extracting Data!                         │
└───────────────────────────────────────────────────────────────────┘${reset}"
extracted_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                 Data Extracted Using AutoExif                     │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
└───────────────────────────────────────────────────────────────────┘"

printf "${usage}"
echo ""
read -e -p"└─────►" file_path

printf "${extracting_data}"
if exiftool "$file_path"; then
  printf "${extracted_data}"
else
  printf "${red}Error: Failed to extract data. Please check the file path.${reset}\n"
fi

read

      ;;
    2)
clear
usage="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│          usage example: ${magenta}/home/username/Pictures/lulz.png ${Blue}         │
├───────────────────────────────────────────────────────────────────┘${reset}"
extracting_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                          Extracting Data!                         │
└───────────────────────────────────────────────────────────────────┘${reset}"
extracted_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                 Data Extracted Using AutoExif                     │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
└───────────────────────────────────────────────────────────────────┘"
printf "${usage}"
echo ""
read -e -p"└─────► " file_path

printf "${extracting_data}"
cat "${file_path}" | exiftool -

printf "${extracted_data}"
read
      ;;
    3)
    clear
usage="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│          usage example: ${magenta}http://a.domain.com/bigfile.jpg${Blue}           │
├───────────────────────────────────────────────────────────────────┘${reset}"
extracting_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                          Extracting Data!                         │
└───────────────────────────────────────────────────────────────────┘${reset}"
extracted_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                 Data Extracted Using AutoExif                     │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
└───────────────────────────────────────────────────────────────────┘"

printf "${usage}"
echo ""
read -e -p"└─────► " file_url

printf "${extracting_data}"
curl -s "${file_url}" | exiftool -fast -

printf "${extracted_data}"
read
      ;;
    4)
    clear
usage="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│          usage example: ${magenta}/home/username/Pictures/lulz.png ${Blue}         │
├───────────────────────────────────────────────────────────────────┘${reset}"
wiping_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                     ${yellow}     Wiping  Data!      ${Blue}                             │
└───────────────────────────────────────────────────────────────────┘${reset}"
wiped_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                     Data Wiped Using AutoExif                     │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
└───────────────────────────────────────────────────────────────────┘"

printf "${usage}"
echo ""
read -e -p"└─────► " file_path
read -p "Enter data type to wipe (JFIF/GPS):" data_type

printf "${wiping_data}"
exiftool -all= --${data_type}:all "${file_path}"

printf "${wiped_data}"
read
      ;;
    5)
    clear
usage="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│          usage example: ${magenta}/home/username/Pictures/lulz.png${Blue}          │
├───────────────────────────────────────────────────────────────────┘${reset}"
wiping_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                          Wiping GPS Data!                         │
└───────────────────────────────────────────────────────────────────┘${reset}"
wiped_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                     Data Wiped Using AutoExif                     │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
└───────────────────────────────────────────────────────────────────┘"

printf "${usage}"
echo ""
read -e -p"└─────► " file_path

printf "${wiping_data}"
exiftool -gps:all= "${file_path}"

printf "${wiped_data}"
read
      ;;
    6)
    clear
usage="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│          usage example: ${magenta}/home/username/Pictures/lulz.png${Blue}          │
├───────────────────────────────────────────────────────────────────┘${reset}"
replacing_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                          Replacing Data!                          │
└───────────────────────────────────────────────────────────────────┘${reset}"
replaced_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                     Data Replaced Using AutoExif                  │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
└───────────────────────────────────────────────────────────────────┘"

printf "${usage}"
echo ""
read -e -p"└─────► " file_path

printf "${replacing_data}"
exiftool -all= -comment='Protected By NULLSecurity Team - AutoExif' "${file_path}"
printf "${replaced_data}"
read
      ;;
    7)
    clear
usage="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│          usage example: ${magenta}/home/username/Videos/lulz.m2ts${Blue}           │
├───────────────────────────────────────────────────────────────────┘${reset}"
extracting_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                          Extracting Data!                         │
└───────────────────────────────────────────────────────────────────┘${reset}"
extracted_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                 Data Extracted Using AutoExif                     │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
└───────────────────────────────────────────────────────────────────┘"
printf "${usage}"
echo ""
read -e -p"└─────► " file_path >> ~/.bash_history

printf "${extracting_data}"
exiftool -ee -p '$gpslatitude, $gpslongitude, $gpstimestamp' "${file_path}"

printf "${extracted_data}"
read
      ;;
    8)
    clear
usage="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│          usage example: ${magenta}/home/username/Pictures/lulz.png${Blue}          │
├───────────────────────────────────────────────────────────────────┘${reset}"
extracting_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                          Extracting Data!                         │
└───────────────────────────────────────────────────────────────────┘${reset}"
extracted_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                 Data Extracted Using AutoExif                     │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
└───────────────────────────────────────────────────────────────────┘"
printf "${usage}"
echo ""
read -e -p"└─────► " file_path

printf "${extracting_data}"
exiftool "${file_path}" -thumbnailimage -b | exiftool -

printf "${extracted_data}"
read
      ;;
    9)
    clear
usage="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│        Delete Photoshop meta information from an image            │
├───────────────────────────────────────────────────────────────────┤
│    (note that the Photoshop information also includes IPTC).      │
└───────────────────────────────────────────────────────────────────┘${reset}"
extracting_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                          Extracting Data!                         │
└───────────────────────────────────────────────────────────────────┘${reset}"
extracted_data="\n${Blue}┌───────────────────────────────────────────────────────────────────┐
│                 Data Extracted Using AutoExif                     │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
└───────────────────────────────────────────────────────────────────┘"

printf "${usage}"
echo ""
read -e -p"└─────► " file_path

printf "${extracting_data}"
if exiftool -Photoshop:All= "$file_path"; then
  printf "${extracted_data}"
else
  printf "${red}Error: Failed to extract data. Please check the file path.${reset}\n"
fi

read
      ;;
    c|C)
clear
echo -e '
┌───────────────────────────────────────────────────────────────────┐
│                    \e[0;31msircryptic@protonmail.com\e[1;34m                      │
├───────────────────────────────────────────────────────────────────┤
│             Press ENTER To Go Back To The Main Menu               │
├───────────────────────────────────────────────────────────────────┘'
read -p "└─────► "
      ;;
      h|H)
clear
printf "${yellow}┌─────────────────────────────────────────────────────────────────────────────┐\n"
printf "│ You can Put This Script In The Desired Folder You Like Where The Media      │\n"
printf "│ Is Located Then You can execute the script if you have the dependencies     │\n"
printf "│ Already Installed.                                                          │\n"
printf "│ when the script is in the media folder you want you can just type the       │\n"
printf "│ Image name Along with file type instead of typing the image location aswell │\n"
printf "│ For eg: instead of /home/username/Pictures/lulz.png                         │\n"
printf "│ I would just type : lulz.png                                                │\n"
printf "│ Alternativly i would just install the script and dependcies together        │\n"
printf "│ Allowing me to just type autoexif to open the script in any cli             │\n"
printf "├─────────────────────────────────────────────────────────────────────────────┤\n"
printf "│                  Press ENTER To Go Back To The Main Menu                    │\n"
printf "└─────────────────────────────────────────────────────────────────────────────┘${reset}\n"
read
      ;;
      i|I)
clear
printf "${yellow}┌───────────────────────────────────────────────────────────────────┐\n"
printf "│                          ExifTool Installation!                   │\n"
printf "└───────────────────────────────────────────────────────────────────┘\n${reset}"
printf "${cyan}┌───────────────────────────────────────────────────────────────────┐\n"
printf "│            Are You Sure You Want To Install ExifTool ?            │\n"
printf "├───────────────────────────────────────────────────────────────────┤\n"
printf "│          PRESS ENTER TO START ANY OTHER OPTION TO CANCEL          │\n"
printf "├───────────────────────────────────────────────────────────────────┘\n${reset}"
read -p "└─────► " r
printf "${red}───────────────────────────────────────────────────────────────────\n"
$r 
printf "${cyan}┌───────────────────────────────────────────────────────────────────┐\n"
printf "│                       Fully Installed ExifTool                    │\n"
printf "├───────────────────────────────────────────────────────────────────┤\n"
printf "│               Press ENTER To Go Back To The Main Menu             │\n"
printf "├───────────────────────────────────────────────────────────────────┘\n"
echo""
read -p "└─────► " r
      ;;
	q|Q)
	clear
  echo "Exiting AutoExif. Goodbye!"
  exit 0
  ;;
    *)
      echo -e ""$red"Invalid "$Blue"option. Please try again."$yellow""
      read -p "Press Enter to continue..."
      ;;
  esac
done
## © 2023 - rjw dly4ever##
