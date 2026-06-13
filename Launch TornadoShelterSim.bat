@echo off
title Tornado Shelter Sim - Launcher
cls

echo.
echo ================================================
echo     TORNADO SHELTER SIM
echo     Spring Jam 26
echo ================================================
echo.
echo This window will stay open so you can read everything.
echo.
timeout /t 2 >nul

:: Check for saved Godot path
set "GODOT_EXE="
if exist "godot_path.txt" (
    set /p GODOT_EXE=<godot_path.txt
    if exist "%GODOT_EXE%" (
        echo Using your saved Godot location...
        echo.
        goto :launch
    )
)

:: Try to find Godot automatically
echo Looking for Godot on your computer...
echo.

if exist "C:\Program Files\Godot\Godot.exe" set "GODOT_EXE=C:\Program Files\Godot\Godot.exe"
if exist "C:\Program Files\Godot\Godot_v4.6.exe" set "GODOT_EXE=C:\Program Files\Godot\Godot_v4.6.exe"
if exist "%USERPROFILE%\Downloads\Godot_v4.6-stable_win64.exe" set "GODOT_EXE=%USERPROFILE%\Downloads\Godot_v4.6-stable_win64.exe"
if exist "%USERPROFILE%\Desktop\Godot.exe" set "GODOT_EXE=%USERPROFILE%\Desktop\Godot.exe"
if exist "D:\Godot\Godot.exe" set "GODOT_EXE=D:\Godot\Godot.exe"

:: Check if Godot is in PATH
where godot >nul 2>&1
if %errorlevel%==0 (
    set "GODOT_EXE=godot"
)

:: If we still didn't find it, ask the user
if "%GODOT_EXE%"=="" (
    goto :ask_for_path
)

:launch
echo.
echo ================================================
echo   Found Godot here:
echo   %GODOT_EXE%
echo ================================================
echo.
echo Opening the project now...
echo.

start "" "%GODOT_EXE%" --path "%~dp0" --editor "res://scenes/world/Main.tscn"

echo.
echo ================================================
echo   Godot should be opening now.
echo   Check your taskbar or Alt+Tab if you don't see it.
echo ================================================
echo.
echo This window will stay open until you press a key.
echo.
pause
exit /b


:ask_for_path
echo.
echo ================================================
echo   GODOT NOT FOUND AUTOMATICALLY
echo ================================================
echo.
echo I could not find Godot on your computer.
echo.
echo Please do ONE of these things:
echo.
echo   Option A (Easiest):
echo     1. Open File Explorer
echo     2. Find your Godot.exe file (usually called Godot.exe or Godot_v4.6.exe)
echo     3. DRAG AND DROP the Godot.exe file onto this black window
echo     4. Then press Enter
echo.
echo   Option B:
echo     Type the full path to Godot.exe and press Enter
echo     Example: C:\Program Files\Godot\Godot.exe
echo.
echo   Option C:
echo     Just close this window and open Godot manually,
echo     then import this folder.
echo.
echo ================================================
echo.

set /p USER_PATH=Drag Godot.exe here or type the path: 

if "%USER_PATH%"=="" (
    echo.
    echo No path entered.
    echo.
    pause
    exit /b
)

:: Remove quotes if the user dragged the file
set "USER_PATH=%USER_PATH:"=%"

if not exist "%USER_PATH%" (
    echo.
    echo ERROR: That file does not exist.
    echo Please try again.
    echo.
    pause
    exit /b
)

:: Save the path for next time
echo %USER_PATH% > godot_path.txt

set "GODOT_EXE=%USER_PATH%"
echo.
echo Thank you! Saving this location for next time...
timeout /t 2 >nul

goto :launch
