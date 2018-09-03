
REM -My awesome backup program! 
goto PROGRAM_START

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

REFERENCES:
Heres a link for more info on robocopy aka RobustCopy! 
http://burpee.smccme.edu/studenthowtos/robocopy.htm
=============================================

:PROGRAM_START


REM -When you run as administrator the local directory changes. Thats why you always use a fully qualified path.
REM @echo Current directory is: %CD%
REM @pause

REM -set as needed
set "source_folder1=C:\Users\Dave\Dropbox"
set "source_folder2=C:\Users\Dave\Desktop"
set "source_folder3=C:\Users\Dave\Documents"
set "source_folder4=C:\Users\Dave\Pictures"
set "source_folder5=C:\A5Webroot"
set "source_folder6=C:\A5Dataroot"
set "source_folder7=C:\Users\Dave\PycharmProjects"

set "source_volume_id=\\?\Volume{b15f4b35-eba0-4eb2-a159-f1d0e4a7cda6}\"
set "source_volume_drive=D:"
set "backup_folder=C:\Users\Dave\Dropbox\BACKS\LOGS"
set "logfile_name=_RB_LOGFILE.txt"
set "exit_stat=ok"

REM -delete previous logs to make it easy to see if all logs arent there at next backup.
del %backup_folder%\Dropboxlog.txt
del %backup_folder%\Desktoplog.txt
del %backup_folder%\Docslog.txt
del %backup_folder%\Picslog.txt
del %backup_folder%\A5Webrootlog.txt
del %backup_folder%\A5Datarootlog.txt
del %backup_folder%\PycharmProjectslog.txt

REM -connect to my external usb drive
mountvol %source_volume_drive% %source_volume_id%

REM -create the logfile
ECHO Started: %date% %time% > %backup_folder%\%logfile_name%
ECHO BACKUP TO DRIVE %source_volume_drive% >> %backup_folder%\%logfile_name%

REM -==================
REM -BEGIN THE BACKUPS
REM -==================

REM -backup my DROPBOX
set "location=Dropbox"
robocopy %source_folder1%\ %source_volume_drive%\ROBOBACKUP\Users\Dave\Dropbox\ /E /PURGE /FP /NDL /NP /TEE /R:1 /W:0 /LOG:%backup_folder%\Dropboxlog.txt
ECHO Error level is %ERRORLEVEL% at %location% Folder... >> %backup_folder%\%logfile_name%
IF %ERRORLEVEL% GTR 7 GOTO bad_exit

REM -backup my DESKTOP
set "location=Desktop"
robocopy %source_folder2%\ %source_volume_drive%\ROBOBACKUP\Users\Dave\Desktop\ /E /PURGE  /FP /NDL /NP /TEE /R:1 /W:0 /LOG:%backup_folder%\Desktoplog.txt
ECHO Error level is %ERRORLEVEL% at %location% Folder... >> %backup_folder%\%logfile_name%
IF %ERRORLEVEL% GTR 7 GOTO bad_exit

REM -backup my DOCUMENTS
set "location=Documents"
robocopy %source_folder3%\ %source_volume_drive%\ROBOBACKUP\Users\Dave\Documents\ /E /PURGE  /FP /NDL /NP /TEE /R:1 /W:0 /LOG:%backup_folder%\Docslog.txt
ECHO Error level is %ERRORLEVEL% at %location% Folder... >> %backup_folder%\%logfile_name%
IF %ERRORLEVEL% GTR 7 GOTO bad_exit

REM -backup my PICTURES
set "location=Pictures"
robocopy %source_folder4%\ %source_volume_drive%\ROBOBACKUP\Users\Dave\Pictures\ /E /PURGE  /FP /NDL /NP /TEE /R:1 /W:0 /LOG:%backup_folder%\Picslog.txt
ECHO Error level is %ERRORLEVEL% at %location% Folder... >> %backup_folder%\%logfile_name%
IF %ERRORLEVEL% GTR 7 GOTO bad_exit

REM -backup ALPHA-ANYWHERE -WEBROOT FOLDER
set "location=A5Webroot"
robocopy %source_folder5%\ %source_volume_drive%\ROBOBACKUP\A5Webroot\ /E /PURGE  /FP /NDL /NP /TEE /R:1 /W:0 /LOG:%backup_folder%\A5Webrootlog.txt
ECHO Error level is %ERRORLEVEL% at %location% Folder... >> %backup_folder%\%logfile_name%
IF %ERRORLEVEL% GTR 7 GOTO bad_exit

REM -backup ALPHA-ANYWHERE -DATAROOT FOLDER
set "location=A5DataRoot"
robocopy %source_folder6%\ %source_volume_drive%\ROBOBACKUP\A5Dataroot\ /E /PURGE  /FP /NDL /NP /TEE /R:1 /W:0 /LOG:%backup_folder%\A5Datarootlog.txt
ECHO Error level is %ERRORLEVEL% at %location% Folder... >> %backup_folder%\%logfile_name%
IF %ERRORLEVEL% GTR 7 GOTO bad_exit

REM -backup PycharmProjects
set "location=PycharmProjects"
robocopy %source_folder7%\ %source_volume_drive%\ROBOBACKUP\Users\Dave\PycharmProjects\ /E /PURGE  /FP /NDL /NP /TEE /R:1 /W:0 /LOG:%backup_folder%\PycharmProjectslog.txt
ECHO Error level is %ERRORLEVEL% at %location% Folder... >> %backup_folder%\%logfile_name%
IF %ERRORLEVEL% GTR 7 GOTO bad_exit

REM ----fall thru to all ok with the backups!
ECHO. >> %backup_folder%\%logfile_name%
ECHO Backups Successful! >> %backup_folder%\%logfile_name%
goto cleanup


REM ----all is NOT OK with the backups!

:bad_exit
ECHO. >> %backup_folder%\%logfile_name%
ECHO FAILURE OCCURED! >> %backup_folder%\%logfile_name%
ECHO Bad Exit with Error level %ERRORLEVEL% failing at the %location% Folder. >> %backup_folder%\%logfile_name%
set "exit_stat=failed"

REM -display codes and unmount the drive then exit

:cleanup
mountvol %source_volume_drive% /p
ECHO. >> %backup_folder%\%logfile_name%
ECHO RoboCopy Exit Codes Meaning: >> %backup_folder%\%logfile_name%
ECHO 0 No errors occurred and no files were copied. >> %backup_folder%\%logfile_name%
ECHO 1 One of more files were copied successfully. >> %backup_folder%\%logfile_name%
ECHO 2 Extra files or directories were detected.  Examine the log file for more information. >> %backup_folder%\%logfile_name%
ECHO 3 (codes 2+1) Some files were copied. Additional files were present. No failure was encountered. >> %backup_folder%\%logfile_name%
ECHO 4 Mismatched files or directories were detected.  Examine the log file for more information. >> %backup_folder%\%logfile_name%
ECHO 5 (4+1) Some files were copied. Some files were mismatched. No failure was encountered. >> %backup_folder%\%logfile_name%
ECHO 6 (4+2) Additional files and mismatched files exist. No files were copied and no failures were encountered. This means that the files already exist in the destination directory. >> %backup_folder%\%logfile_name%
ECHO 7 (4+1+2) Files were copied, a file mismatch was present, and additional files were present. >> %backup_folder%\%logfile_name%
ECHO 8 Some files or directories could not be copied and the retry limit was exceeded. >> %backup_folder%\%logfile_name%
ECHO 9 Possible Disk Failure or Disk Full. >> %backup_folder%\%logfile_name%
ECHO 16 Possible no drive is connected. Robocopy did not copy any files.  Check the command line parameters and verify that Robocopy has enough rights to write to the destination folder. >> %backup_folder%\%logfile_name%

REM -if failure occured then place an extra copy of the logfile to be seen on the desktop!
IF %exit_stat% EQU failed copy %backup_folder%\%logfile_name% C:\Users\Dave\Desktop

exit /b %ERRORLEVEL%




