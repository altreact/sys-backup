#!/usr/bin/env bash

# verify script is ran as root
## if not, end script
if [ "$(whoami)" != 'root' ]; then	
	echo
	echo 'script must be ran as root'
	echo 
	echo "try 'sudo sh sys-backup.sh'"
	echo	
	exit 1
fi

# create empty temp dir that will hold full sys backup
mkdir /tmp/sys-backup 2> /dev/null
rm -rf /tmp/sys-backup/* 

# var for path to backup dir
bpath='/tmp/sys-backup'

# create directory that will hold full system backup .tar.gz
bdir='~/sys-backup'

# rsync backup to backup dir
rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","home/*/.thumbnails/*","/home/*/.cache/*","/home/*/.local/share/Trash/*"} / $bpath

<<c
# make filename based on time and date
#gotta figure out how to do this
c

<<c
# tar contents of backup dirs
cd $bpath
tar -czvf * $ sys-backup.tar.gz | $(echo 'tar failed' && exit 1)

exit 1

# move full sys backup tarball to user specified backup dir
mv sys-backup.tar.gz $bdir

# delete temp backup dir
