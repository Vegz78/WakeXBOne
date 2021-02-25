@echo off
REM A script to remotely power on a XBox One from a Windows PC via a Linux device's IR device, from https://github.com/Vegz78/WakeXBOne
REM This script requires plink(from Putty) on Windows and https://github.com/Vegz78/WakeXBOne to run on the Linux device
REM Remember to edit the global variables to fit your requirements before executing   


REM Gobal variables
SET "REMOTEUSER="	&REM The username to log on with to the remote device containing the _WakeXBOne.sh script
SET "REMOTEPASSWORD="	&REM NB!: UNSAFE AND NOT RECOMMENDED, but you may use password here for disabling all interaction in script execution
SET "REMOTEHOST=192.168.0.1"	&REM IP address or host name of the remote device containing the _WakeXBOne.sh script
SET "REMPATHCOMMAND=/../../_WakeXBOne.sh"	&REM The remote path and name of the script file to execute remotely
SET "XBOneIP=192.168.0.2"	&REM The IP address of the XBox One if static and available
SET "PINGCOUNT=10"	&REM Number of times to try to ping the XBox One before exiting script


REM Check if XBox One already is on
ping -n 1 "%XBOneIP%" | FINDSTR /R /C:"[0-9] *ms"

IF %ERRORLEVEL% == 0 (
	GOTO :FINISHSCRIPT
)


REM Turn on XBox One over Linux with the remotely executed script _WakeXBOne.sh
IF NOT "%REMOTEPASSWORD%"=="" (plink -batch %REMOTEUSER%@%REMOTEHOST% -pw %REMOTEPASSWORD% %REMPATHCOMMAND%) ELSE (plink %REMOTEUSER%@%REMOTEHOST% %REMPATHCOMMAND%)

REM Alternative without the plink no-spoofing interactive RETURN-prompt
REM NOT "%REMOTEPASSWORD%"=="" (plink -batch %REMOTEUSER%@%REMOTEHOST% -pw %REMOTEPASSWORD% %REMPATHCOMMAND%) ELSE (plink -no-antispoof %REMOTEUSER%@%REMOTEHOST% %REMPATHCOMMAND%)


REM Wait until XBox One is powered on and responds on the network
SET COUNTER=1
:PINGTHEXBOX
ECHO Pinging the XBox One...(%COUNTER%/%PINGCOUNT%)
ping -n 1 "%XBOneIP%" | FINDSTR /R /C:"[0-9] *ms"
IF %ERRORLEVEL% == 0 (
	GOTO :FINISHSCRIPT
) ELSE (
	SET /A COUNTER=COUNTER+1
	IF %COUNTER%==%PINGCOUNT% (GOTO :EXITSCRIPT) ELSE (GOTO :PINGTHEXBOX)
)


:EXITSCRIPT
ECHO XBox One not found within set ping count, exiting script
CALL :EXITING
EXIT /B 1

:FINISHSCRIPT
ECHO XBox One online!...
CALL :EXITING
EXIT /B 0


:EXITING
REM Subroutine that clears all used variables
SET "COUNTER="
SET "REMOTEUSER="
SET "REMOTEPASSWORD="
SET "REMOTEHOST="
SET "REMPATHCOMMAND="
SET "XBOneIP="
SET "PINGCOUNT="
EXIT /B