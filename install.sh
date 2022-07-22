#!/bin/bash
clear
echo -e '\e[1;33m
 _______   ____ ___.____    .____       _________              
 \      \ |    |   \    |   |    |     /   _____/ ____   ____  
 /   |   \|    |   /    |   |    |     \_____  \_/ __ \_/ ___\ 
/    |    \    |  /|    |___|    |___  /        \  ___/\  \___ 
\____|__  /______/ |_______ \_______ \/_______  /\___  >\___  >
        \/NULLSecurity Team\/       \/        \/     \/     \/ \e[1;34m
'
echo "[✔] Checking directories...";
if [ -d "/usr/share/doc/autoexif" ] ;
then
echo "[◉] A directory AutoExif was found! Do you want to replace it? [Y/n]:" ; 
read selection
if [ $selection == "y" ] ; 
then
 rm -r "/usr/share/doc/autoexif"
else
 exit
fi
fi

echo "[✔] Installing ...";
echo "";
sudo apt-get install exif libimage-exiftool-perl libstring-crc32-perl libgd-perl
git clone https://github.com/SirCryptic/autoexif /usr/share/doc/autoexif;
echo "#!/bin/bash 
bash /usr/share/doc/autoexif/autoexif.sh" '${1+"$@"}' > autoexif;
chmod +x autoexif;
sudo cp autoexif /usr/bin/;
rm autoexif;
if [ -d "/usr/share/doc/autoexif" ] ;
then
echo -e '\e[1;33m
   _____          __        ___________      .__  _____ 
  /  _  \  __ ___/  |_  ____\_   _____/__  __|__|/ ____\
 /  /_\  \|  |  \   __\/  _ \|    __)_\  \/  /  \   __\ 
/    |    \  |  /|  | (  <_> )        \>    <|  ||  |   
\____|__  /____/ |__|  \____/_______  /__/\_ \__||__|   
        \/  AutoExif v1.2           \/      \/\e[1;34m
                                
                                Created by "SirCryptic ~ NULLSec"\e[1;31m
  The Developer is NOT responsible for any damage or info leaked by this script.
[✔]====================================================================[✔]
[✔]               autoexif installed successfully!                     [✔]
[✔]====================================================================[✔]
[✔]  You can execute the script by typing `autoexif` in any terminal!  [✔]
[✔]====================================================================[✔]
\e[1;36m
'
else
  echo "[✘] Installation failed![✘] ";
  exit
fi
