@echo off
rem ----------------------------------------
rem Get current folder name as program name
rem ----------------------------------------
set DIR_CURRENT=%~dp0
for %%i in ("%DIR_CURRENT:~0,-1%") do set TARGET=%%~ni.rb

call ruby %TARGET%
