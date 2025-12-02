@echo off
setlocal

cd /d "%~dp0"

if "%1"=="" goto help

if "%1"=="setup" goto setup
if "%1"=="build" goto build
if "%1"=="release" goto release
if "%1"=="run" goto run
if "%1"=="clean" goto clean
if "%1"=="help" goto help

echo Unknown command: %1
goto help

:setup
echo.
echo ========================================
echo MuseScore Development Setup (Windows)
echo ========================================
echo.
echo Please ensure you have installed the following:
echo 1. Visual Studio 2022 (Community Edition is fine) with C++ workload.
echo 2. Qt 6.8 or later (via Qt Online Installer).
echo 3. CMake (usually included in Visual Studio or install separately).
echo 4. Ninja (optional, for faster builds).
echo.
echo When installing Qt, make sure to select the MSVC 2022 64-bit component.
echo.
goto end

:build
echo Building MuseScore (Debug)...
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug
goto end

:release
echo Building MuseScore (Release)...
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Release
goto end

:run
echo Running MuseScore...
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug run
goto end

:clean
echo Cleaning build directory...
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug clean
goto end

:help
echo Usage: dev.bat [command]
echo.
echo Commands:
echo   setup       Show setup instructions
echo   build       Build MuseScore (Debug mode)
echo   release     Build MuseScore (Release mode)
echo   run         Run the compiled MuseScore (Debug mode)
echo   clean       Clean the build directory
echo   help        Show this help message
echo.
goto end

:end
endlocal
