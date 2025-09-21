@echo off
rem ----------------------------------------
rem Get current folder name as program name
rem ----------------------------------------
set DIR_CURRENT=%~dp0
for %%i in ("%DIR_CURRENT:~0,-1%") do set TARGET=%%~ni.rb


rem set OPT=--jit

if exist "../Gemfile.lock" (
  call bundle exec ruby %OPT% %TARGET%
) else (
  call ruby %OPT% %TARGET%
)
