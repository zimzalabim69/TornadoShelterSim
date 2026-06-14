@echo off
title Launch Obsidian Vault - Tornado Shelter Sim

echo ================================================
echo   Tornado Shelter Sim - Professional Notes Vault
echo ================================================
echo.
echo Opening Obsidian with the project vault...

set "OBSIDIAN_EXE=C:\Users\sikke\AppData\Local\Programs\Obsidian\Obsidian.exe"
set "VAULT_PATH=C:\Users\sikke\Projects\TornadoShelterSim\docs\Obsidian Vault"

if not exist "%OBSIDIAN_EXE%" (
    echo ERROR: Obsidian not found at expected location.
    echo Please install Obsidian or update this bat file.
    pause
    exit /b
)

start "" "%OBSIDIAN_EXE%" "%VAULT_PATH%"

echo Vault launched.
timeout /t 2 >nul