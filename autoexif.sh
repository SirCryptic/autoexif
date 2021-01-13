#!/bin/bash
##############################
##        Auto Exif         ##
##############################
##  Created By Sir Cryptic  ##
############################## 
##  Developer Sir Cryptic   ## 
##############################
##    NULL Security Team    ##
##       Greetz Mobly       ##
##       Greetz R!ff        ##
##############################
############################## 
##      Developed On        ##
##        BackBox           ##
##############################
i="0"
clear
while [ $i -lt 1 ]
do
clear
#COLOUR
red='\e[1;31m'
yellow='\e[0;33m'
Blue='\e[1;34m'
title="Auto~Exif"
echo -e '\033]2;'$title'\007'

 echo -e "▌║█║▌│║▌│║▌║▌█║AutoExif ▌│║▌║▌│║║▌█║▌║█"
 echo -e '\e[0;33m-------------------------------------------------------------------------
\e[1;31mExif Tool AutoMated For Easy Conveinience\e[3;34m Created by "Sir Cryptic"\e[0m \e[1;31m
\e[0;33m-------------------------------------------------------------------------
\e[0m \e[1;31mYou Must Install Dependencies For This Script To Work Properly\e[3;39m
\e[0;33m-------------------------------------------------------------------------\e[0m
(1) Read Image MetaData (Basic)
(2) Read Image MetaData (Expert)
(3) Read Image MetaData (From Website)
(4) Wipe Data From Image (Except JFIF Groups)
(5) Wipe All GPS Data From Image
(6) Wipe All MetaData From Image (Adds Comment Back In) 
(7) Extract GPS from AVCH video 
(8) Extract Info From Thumbnail
(9) Wipe Photoshop MetaData
(h) Help
(i) Install Dependencies
(c) Contact Information
-------------------------------
       CTRL + C To Exit
-------------------------------'

echo -e $Blue" ┌─["$red"Auto$Blue]──[$red~$Blue]─["$yellow"Exif$Blue]:"
read -p " └─────► " x
option1='1'
option2='2'
option3='3'
option4='4'
option5='5'
option6='6'
option7='7'
option8='8'
option9='9'
info='h'
installdeps='i'
contact='c'

if [ "$x" == "$option1" ]; then                    #readmetadata basic
clear
echo "enter image name followed by its file type eg: /home/username/Pictures/lulz.png"
read meta1
echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!        Extracting Data        !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'

exiftool $meta1

echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! Data Extracted using AutoExif !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Press ENTER To Go Back To The Main Menu
'

read


elif [ "$x" == "$option2" ]; then                          #readmetadatadeep
clear
echo "enter image name followed by its file type eg: /home/username/Pictures/lulz.png"
read mdeep
echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!        Extracting Data        !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'

cat $mdeep | exiftool -

echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! Data Extracted using AutoExif !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Press ENTER To Go Back To The Main Menu
'

read

elif [ "$x" == "$option3" ]; then                          #webextract
clear
echo "enter image location for eg: http://a.domain.com/bigfile.jpg"
read pi1host
echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!        Extracting Data        !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'

curl -s $pi1host | exiftool -fast -

echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! Data Extracted using AutoExif !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Press ENTER To Go Back To The Main Menu
'

read

elif [ "$x" == "$option4" ]; then                          #Option4
clear
echo "enter image name followed by its file type eg: /home/username/Pictures/lulz.png"
read pi4
echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!       Wiping JFIF Data        !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'

exiftool -all= --jfif:all $pi4

echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!   Data Wiped Using AutoExif   !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Press ENTER To Go Back To The Main Menu
'

read


elif [ "$x" == "$option5" ]; then                          #AVCHextract
clear
echo "enter image name followed by its file type eg: /home/username/Pictures/lulz.png"
read pi5
echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!        Wiping GPS Data        !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'

exiftool -gps:all= $pi5

echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!   Data Wiped Using AutoExif   !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Press ENTER To Go Back To The Main Menu
'

read

elif [ "$x" == "$option6" ]; then                          #Option6
clear
echo "enter image name followed by its file type eg: /home/username/Pictures/lulz.png"
read pi6
echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!        Replacing Data         !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'

exiftool -all= -comment='Protected By NULLSecurity Team' $pi6

echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!! Data Replaced Using AutoExif !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Press ENTER To Go Back To The Main Menu
'

read

elif [ "$x" == "$option7" ]; then                          #Option7
clear
echo "enter image name followed by its file type eg: /home/username/Videos/lulz.m2ts"
read avch
echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!        EXTRACTING PLEASE WAIT        !
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
'

exiftool -ee -p '$gpslatitude, $gpslongitude, $gpstimestamp' $avch

echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! Data Extracted using AutoExif !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Press ENTER To Go Back To The Main Menu
'

read



elif [ "$x" == "$option8" ]; then                          #AVCHExtract
clear
echo "enter image name followed by its file type eg: /home/username/pictures/lulz.png"
read pi8
echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!        EXTRACTING PLEASE WAIT        !
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
'

exiftool $pi8 -thumbnailimage -b | exiftool -

echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! Data Extracted using AutoExif !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Press ENTER To Go Back To The Main Menu
'

read


elif [ "$x" == "$option9" ]; then                          #Option9
clear
echo -e '
Delete Photoshop meta information from an image (note that the Photoshop informatio nalso includes IPTC).
enter image name followed by its file type eg: /home/username/pictures/lulz.jpg
'
read psd
echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!        EXTRACTING PLEASE WAIT        !
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
'

exiftool -Photoshop:All= $psd

echo -e '
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! Data Extracted using AutoExif !!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Press ENTER To Go Back To The Main Menu
'

read



elif [ "$x" == "$info" ]; then                          #Option10

clear
echo -e '\e[1;33m
\e[0m
 \e[1;31m
You can Put This Script In The Desired Folder You Like Where The Media
Is Located Then You can execute the script
when the script is in the media folder you want you can just type the
Image name Along with file type instead of typing the image location aswell
For eg: instead of /home/username/Pictures/lulz.png
I would just type : lulz.png
                          Press ENTER To Go Back To The Main Menu
'
read

elif [ "$x" == "$installdeps" ]; then                          #Option10
clear
echo -e '\e[0;31m-------------------------------\e[1;33m
ExifTool Installation
\e[0;31m-------------------------------\e[1;34m'
echo "Are You Sure You Want To Install ExifTool ?"
echo "PRESS ENTER TO START ANY OTHER OPTION TO CANCEL"
echo -e '\e[0;31m-------------------------------'
read -p "~" r
echo -e '\e[0;31m-------------------------------\e[0;39m'
$r sudo apt-get install exif libimage-exiftool-perl libstring-crc32-perl libgd-perl
echo -e '\e[0;31m-------------------------------\e[1;33m
Fully Installed ExifTool
\e[0;31m-------------------------------\e[1;34m'
echo "Press ENTER To Go Back To Main Menu"
read -p '-------------------------------'

elif [ "$x" == "$contact" ]; then                 #CONTACTME                    

clear

echo -e '\e[1;33m
\e[0m
 \e[1;31m
 no-reply@nullsec.online
 https://nullsec.online
                          Press ENTER To Go Back To The Main Menu
'
read


else 

n


fi

done
