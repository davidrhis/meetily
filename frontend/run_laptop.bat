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
    echo [1/2] Installing frontend dependencies with pnpm...
    call pnpm install
) else (
    echo [1/2] node_modules found, skipping re-install.
)

echo [2/2] Starting Tauri in CPU mode (Jobs: 2)...
call pnpm run tauri:dev:cpu
