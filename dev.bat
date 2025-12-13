@echo off
setlocal

cd /d "%~dp0"

:: Initial variables
set "GENERATOR_ARGS="
set "NEED_VS_ENV=0"
set "COMMAND="

:: Parse arguments
if "%~1"=="" goto help

:: We need to extract the command (first argument)
set "COMMAND=%~1"

:: Check for Ninja flag in arguments
:: We loop through all arguments to find -ninja or --ninja
for %%a in (%*) do (
    if /i "%%a"=="-ninja" (
        set "GENERATOR_ARGS=-G Ninja"
        set "NEED_VS_ENV=1"
    )
    if /i "%%a"=="--ninja" (
        set "GENERATOR_ARGS=-G Ninja"
        set "NEED_VS_ENV=1"
    )
)

:: Also support explicit commands like build-ninja
if /i "%COMMAND%"=="build-ninja" (
    set "COMMAND=build"
    set "GENERATOR_ARGS=-G Ninja"
    set "NEED_VS_ENV=1"
)

:: If Ninja is requested, we MUST setup the VS environment for cl.exe
if "%NEED_VS_ENV%"=="1" call :setup_vs_env

if /i "%COMMAND%"=="setup" goto setup
if /i "%COMMAND%"=="build" goto build
if /i "%COMMAND%"=="release" goto release
if /i "%COMMAND%"=="run" goto run
if /i "%COMMAND%"=="test" goto test
if /i "%COMMAND%"=="clean" goto clean
if /i "%COMMAND%"=="help" goto help

echo Unknown command: %1
goto help

:setup_vs_env
if defined VCINSTALLDIR goto :eof
echo Setting up Visual Studio Environment for Ninja...
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" set "VSWHERE=%ProgramFiles%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" (
    echo Error: vswhere.exe not found. Cannot locate Visual Studio.
    exit /b 1
)
set "VS_INSTALL_DIR="
for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
    set "VS_INSTALL_DIR=%%i"
)
if "%VS_INSTALL_DIR%"=="" (
    echo Error: Visual Studio with C++ tools not found.
    exit /b 1
)
echo Found VS at: %VS_INSTALL_DIR%
call "%VS_INSTALL_DIR%\VC\Auxiliary\Build\vcvars64.bat" >nul
exit /b 0

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
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug %GENERATOR_ARGS%
goto end

:release
echo Building MuseScore (Release)...
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Release %GENERATOR_ARGS%
goto end

:run
echo Running MuseScore...
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug %GENERATOR_ARGS% run
goto end

:test
echo Building and Running Tests...
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug %GENERATOR_ARGS% test
goto end

:clean
echo Cleaning build directory...
cmake -P build.cmake -DCMAKE_BUILD_TYPE=Debug %GENERATOR_ARGS% clean
goto end

:help
echo Usage: dev.bat [command] [-ninja]
echo.
echo Commands:
echo   setup       Show setup instructions
echo   build       Build MuseScore (Debug mode)
echo   release     Build MuseScore (Release mode)
echo   run         Run the compiled MuseScore (Debug mode)
echo   test        Build and run unit tests
echo   clean       Clean the build directory
echo   help        Show this help message
echo.
echo Options:
echo   -ninja      Use Ninja build system (requires Ninja installed)
echo               Example: dev.bat build -ninja
echo.
goto end

:end
endlocal
