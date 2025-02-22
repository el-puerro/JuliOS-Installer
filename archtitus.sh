#!/bin/bash
#github-action genshdoc

# Find the name of the folder the scripts are in
set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/configs
set +a
echo -ne "
_________          _       _________ _______  _______ 
\__    _/|\     /|( \      \__   __/(  ___  )(  ____ \
   )  (  | )   ( || (         ) (   | (   ) || (    \/
   |  |  | |   | || |         | |   | |   | || (_____ 
   |  |  | |   | || |         | |   | |   | |(_____  )
   |  |  | |   | || |         | |   | |   | |      ) |
|\_)  )  | (___) || (____/\___) (___| (___) |/\____) |
(____/   (_______)(_______/\_______/(_______)\_______)
                                                      
v1.1
"
    ( bash $SCRIPT_DIR/scripts/startup.sh )|& tee startup.log
      source $CONFIGS_DIR/setup.conf
    ( bash $SCRIPT_DIR/scripts/0-preinstall.sh )|& tee 0-preinstall.log
    ( arch-chroot /mnt $HOME/ArchTitus/scripts/1-setup.sh )|& tee 1-setup.log
    if [[ ! $DESKTOP_ENV == server ]]; then
      ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/ArchTitus/scripts/2-user.sh )|& tee 2-user.log
    fi
    ( arch-chroot /mnt $HOME/ArchTitus/scripts/3-post-setup.sh )|& tee 3-post-setup.log
    cp -v *.log /mnt/home/$USERNAME

echo -ne "
_________          _       _________ _______  _______ 
\__    _/|\     /|( \      \__   __/(  ___  )(  ____ \
   )  (  | )   ( || (         ) (   | (   ) || (    \/
   |  |  | |   | || |         | |   | |   | || (_____ 
   |  |  | |   | || |         | |   | |   | |(_____  )
   |  |  | |   | || |         | |   | |   | |      ) |
|\_)  )  | (___) || (____/\___) (___| (___) |/\____) |
(____/   (_______)(_______/\_______/(_______)\_______)
                                                      
v1.1
Done - Please Eject Install Media and Reboot
"
