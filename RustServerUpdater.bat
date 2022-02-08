@echo off
color 0a

rem ======== ONLY CHANGE THESE LINES ========
set steamCMDPath="C:\steamcmd\steamcmd.exe"
set serverPath="C:\Rust\server1"
rem ======== ONLY CHANGE THESE LINES ========

GOTO :MAIN

:UpdateOxide 
@echo ======== Downloading Oxide Update ========
curl -L "https://github.com/OxideMod/Oxide.Rust/releases/latest/download/Oxide.Rust.zip" --output "%serverPath%\Oxide.Rust.zip"
@powershell.exe -Command "expand-archive -force -literalpath '%serverPath%\Oxide.Rust.zip' -destinationpath %serverPath%"

@echo ======== Deleting ZIP File ========
del "%serverPath%\Oxide.Rust.zip"
EXIT /B 0

:UpdateServerAndValidate
@echo ======== Updating Rust Server ========
%steamCMDPath% +force_install_dir %serverPath% +login anonymous +app_update 258550 validate +quit
EXIT /B 0

:UpdateServer
@echo ======== Updating Rust Server ========
%steamCMDPath% +force_install_dir %serverPath% +login anonymous +app_update 258550 +quit
EXIT /B 0

:MAIN
set /p opt="Select An Option (1 = Update Server, 2 = Update Oxide, 3 = Update Both, 4 = Update Both & Validate): "
if %opt% == 1 call :UpdateServer
if %opt% == 2 call :UpdateOxide
if %opt% == 3 call :UpdateServer & call :UpdateOxide
if %opt% == 4 call :UpdateServerAndValidate & call :UpdateOxide