@echo off
:: This script is used to create an android project.
:: You should modify _ANDROIDTOOLS _CYGBIN _NDKROOT to work under your environment.
:: Don't change it until you know what you do.

setlocal

:: Check if it was run under cocos2d-x root
if not exist "%cd%\create-android-project.bat" echo Error!!! You should run it under cocos2dx root & pause & exit 2	

if not exist "%~dpn0.sh" echo Script "%~dpn0.sh" not found & pause & exit 3

:: modify it to work under your environment	 
set _CYGBIN=f:\cygwin\bin
if not exist "%_CYGBIN%" echo Couldn't find Cygwin at "%_CYGBIN%" & pause & exit 4

:: modify it to work under your environment
set _ANDROIDTOOLS=d:\android-sdk\tools
if not exist "%_ANDROIDTOOLS%" echo Couldn't find android sdk tools at "%_ANDROIDTOOLS%" & pause & exit 5

:: modify it to work under your environment
set _NDKROOT=e:\android-ndk-r4-crystax
if not exist "%_NDKROOT%" echo Couldn't find ndk at "%_NDKROOT%" & pause & exit 6

:: create android project
set _PACKAGEPATH=org.cocos2dx.application
set /P _PROJECTNAME=Please enter your project name:
echo "Use android.bat list targets to obtain a list of available targets before your inputting."
echo "Now cocos2d-x suppurts Android 2.1-update1 and Android 2.2"
echo "Other target id may support, but have not tested."
echo "input target id:"
set /P _TARGETID=Please enter target id:
set _PROJECTDIR=%CD%\%_PROJECTNAME%

echo Create android project
call %_ANDROIDTOOLS%\android.bat create project -n %_PROJECTNAME% -t %_TARGETID% -k %_PACKAGEPATH% -a %_PROJECTNAME% -p %_PROJECTDIR%
	 
:: Resolve ___.sh to /cygdrive based *nix path and store in %_CYGSCRIPT%
for /f "delims=" %%A in ('%_CYGBIN%\cygpath.exe "%~dpn0.sh"') do set _CYGSCRIPT=%%A

:: Resolve current dir to cygwin path
for /f "delims=" %%A in ('%_CYGBIN%\cygpath.exe "%cd%"') do set _CURRENTDIR=%%A

:: Resolve ndk dir to cygwin path
for /f "delims=" %%A in ('%_CYGBIN%\cygpath.exe "%_NDKROOT%"') do set _NDKROOT=%%A
	 
:: Throw away temporary env vars and invoke script, passing any args that were passed to us
endlocal & %_CYGBIN%\bash --login "%_CYGSCRIPT%" %_CURRENTDIR% %_PROJECTNAME% %_NDKROOT% "windows"
