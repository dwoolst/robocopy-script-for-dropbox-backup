============================================

Author: SuperDave Mixalot

THE WHY OF IT ALL:
Ever since my old server got hacked with a virus and I wouldnt pay bitcoin to retrieve my data, I lost it all. A sad day indeed, but I’ve returned and solved the issue. So I offer you my robocopy batchfile. It first connects to my backup drive, backs up all needed data, then disconnects from the drive to keep it protected from any issues which may befall my online pc.


WHAT IT DOES:
I use RoboCopy to do a version of what's called a "Mirror", making the specified folders on your ext drive be an exact copy of your source folders. This happends when using the /PURGE option so that if a file is deleted at the source then it gets deleted at the destination so it wont take up unnecessary space on your backup drive. A great side benefit of this differential type backup is that subsequent backups happen extremely fast. Note: No files are ever deleted at the source.
I have created three scripts. The first two are just test scripts to make sure mount and unmount are working ok the pc. The third one does the backups.
mount.bat - mounts your ext drive (just used for testing purposes, not needed to do backups) 
unmount.bat - disconnects it. (just used for testing purposes, not needed to do backups) 
robobackup.bat - The backer-upper. It backs up all needed files to your attached drive. This scipt is the one that will be used and run by the windows Task Scheduler.

STEP 1:
First is to determine what your backup drive's volume and drive letter are. Goto a command prompt and type: Mountvol > test.txt and it will fill the text file with all of your attached drive IDs. Copy and Paste the long “Volume Name” of the drive letter you are wanting to mount/unmount to. You will use it in the scripts and it will look something like this: \\?\Volume{b15f4b35-eba0-4eb2-a159-f1d0e4a7cda6}\

STEP 2:
Modify both the mount.bat and unmount.bat files and test that they function properly. Remember that you always have to right-click and run them "As Administrator" so they work ok. The UAC(user access control) pops up but just click Yes. 

STEP 3:
Next you modify the robobackup.bat file with the volume ID of your backup drive and the folders you want to backup. It's safe because the only files that ever get deleted are the ones that are sitting on your backupdrive (the destination) that you don't want to keep anymore. No files are ever deleted at the source.
Regarding the Windows Task Scheduler, you can set it to run RoboBackup.bat with highest privileges so the UAC wont popup, only the drive window stays up while the backup is taking place, then it goes away when all backups are completed and it unmounts.

All Robocopy Options I use:
 Copy-Options:
 /E :: copy subdirectories, including Empty ones.
 /PURGE :: delete dest files/dirs that no longer exist in source.
 (OR you could use /MIR :: MIRror a directory tree (equivalent to /E plus /PURGE))
 Retry-Options:
 /R:n :: number of Retries on failed copies: default 1 million.
 /W:n :: Wait time between retries: default is 30 seconds.
 Logging-Options:
 /FP :: include Full Pathname of files in the output.
 /NDL :: No Directory List - don't log directory names.
 /NP :: No Progress - don't display % copied.
 /TEE :: output to console window, as well as the log file.
 /LOG:file :: output status to LOG file (overwrite existing log).
 
=============================================
