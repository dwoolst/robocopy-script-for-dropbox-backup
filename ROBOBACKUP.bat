
REM My super awesome backup program! 

REM connect to my ext usb drive
mountvol Q: \\?\Volume{3f89afa7-dfac-11e3-beb7-eca86b372bcf}\ 

REM backup my dropbox
robocopy C:\Users\Dave\Dropbox\ Q:\ROBOBACKUP\Users\Dave\Dropbox\ /E /PURGE /FP /NDL /NP /TEE /LOG:\Users\Dave\Desktop\Dropboxlog.txt

REM backup my desktop
robocopy C:\Users\Dave\Desktop\ Q:\ROBOBACKUP\Users\Dave\Desktop\ /E /PURGE  /FP /NDL /NP /TEE /LOG:\Users\Dave\Desktop\Desktoplog.txt

REM backup my documents
robocopy C:\Users\Dave\Documents\ Q:\ROBOBACKUP\Users\Dave\Documents\ /E /PURGE  /FP /NDL /NP /TEE /LOG:\Users\Dave\Desktop\Docslog.txt

REM backup any LIVE Alpha-Anywhere (formely Alpha Five) program changes and their data files
robocopy C:\A5Webroot\ Q:\ROBOBACKUP\A5Webroot\ /E /PURGE  /FP /NDL /NP /TEE /LOG:\Users\Dave\Desktop\A5Webrootlog.txt
robocopy C:\A5Dataroot\ Q:\ROBOBACKUP\A5Dataroot\ /E /PURGE  /FP /NDL /NP /TEE /LOG:\Users\Dave\Desktop\A5Datarootlog.txt

REM disconnect and done!
mountvol Q: /p 




