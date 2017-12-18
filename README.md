
# robocopy-script-for-dropbox-backup
Using robocopy scripts with task manager has completely automated my local backups, 
and I can now leave my drive plugged in all the time because when its Unmounted its not readable so its safe from any virus the PC 
may acquire via Vidme pornorama or Russian hackers lol.


THE WHY OF IT ALL:
I have an external drive to backup my data. But what I get attacked by ransomeware and it encrypts the ext hd too? Ive been afraid of that ever since my old server got hacked with a virus and I wouldnt pay bitcoin to retrieve my data, so I lost it. But Ive solved the issue.
Ive devised a script(macro) to automate backups of all the data on my pc(which includes all of dropbox) so that it connects my ext drive to my pc, backs up all its data, then disconnects to keep it separate from my basically unsecure(because its online) pc.

WHAT IT DOES:
My backup scheme does whats called a "Mirror" to make the specified folders on your ext drive be an exact copy of your source folders, so that if you delete a file on your source it wont take up unnecessary space on your backup drive. A great side benefit is that this "Mirror" is really a synchronization so that your subsequent backups happen extremely fast! 

I have created these 3 scripts:
MOUNT.BAT
UNMOUNT.BAT
ROBOBACKUP.BAT

The first two are just test scripts to make sure mount and unmount are working ok the pc.
mount.bat - mounts your ext drive (just used for testing purposes, not needed to do backups) 
unmount.bat - disconnects it. (just used for testing purposes, not needed to do backups) 

This last scipt is the one that will be used and run by the windows Task Scheduler:
robobackup.bat - The backer-upper! It backs up all your needed files to your ext drive. 

LETS GET STARTED:
To start, modify the mount/unmount bat files and test that they function properly. Remember that you always have to run the "as Administrator" so they work ok. The UAC(user access control) pops up but just clik yes. 
First use Mountvol to get vol name of your ext drive, open up a Command Prompt as Administrator.
Run the command mountvol and take note of the Volume Name above the drive letter you are wanting to mount/unmount (eg. \\?\Volume{########-####-####-####-############}\ )

To unmount a drive type mountvol [DriveLetter] /p. Be sure to replace "[DriveLetter]" with the letter assigned to the drive you wish to unmount, for example, G:
To mount a drive type mountvol [DriveLetter] [VolumeName]. Make sure you replace "[DriveLetter]" with the letter you wish to mount the drive to, for example, G:, and "[VolumeName]" with the Volume Name you noted in Step 2.

Next you can modify the robobackup.bat file with the folders you want to backup. Its safe because the only files that ever get deleted are the ones that were sitting on your backupdrive (the destination) that you don't want to keep anymore. 
Also note that in Task Scheduler you can set it to run RoboBackup.bat with highest privileges so the UAC wont popup, only the command prompt window stays up while the backup is taking place, then it goes away when all backups are completed and it unmounts the usb ext dive. Yeah! 

REFERENCES:
Heres a link for more info on robocopy aka RobustCopy! 
http://burpee.smccme.edu/studenthowtos/robocopy.htm
