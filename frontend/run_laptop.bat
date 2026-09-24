@echo off
echo ============================================================
echo Meetily Dev Runner (Low-Resource / Intel Laptop Optimized)
echo Hardware Target: 2 Cores / 8 GB RAM (CPU Native Mode)
echo ============================================================

set CARGO_BUILD_JOBS=2
set NEXT_TELEMETRY_DISABLED=1
set "VS_CMAKE=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin"
set "PATH=%USERPROFILE%\.cargo\bin;%USERPROFILE%\.libclang;%VS_CMAKE%;%PATH%"
set "LIBCLANG_PATH=%USERPROFILE%\.libclang"

if not exist node_modules (
    echo [1/3] Installing frontend dependencies with pnpm...
    call pnpm install
) else (
    echo [1/3] node_modules found, skipping re-install.
)

echo [2/3] Checking llama-helper sidecar binary...
if not exist "src-tauri\binaries\llama-helper-x86_64-pc-windows-msvc.exe" (
    echo    Sidecar not found. Building llama-helper...
    pushd ..
    cargo build -p llama-helper
    popd
    if not exist "src-tauri\binaries" mkdir "src-tauri\binaries"
    copy /Y "..\target\debug\llama-helper.exe" "src-tauri\binaries\llama-helper-x86_64-pc-windows-msvc.exe" >nul
    echo    llama-helper sidecar prepared.
) else (
    echo    llama-helper sidecar already present.
)

echo [3/3] Starting Tauri in CPU mode (Jobs: 2)...
call pnpm run tauri:dev:cpu
