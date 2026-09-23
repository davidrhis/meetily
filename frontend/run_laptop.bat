@echo off
echo ============================================================
echo Meetily Dev Runner (Low-Resource / Intel Laptop Optimized)
echo Hardware Target: 2 Cores / 8 GB RAM (CPU OpenBLAS mode)
echo ============================================================

set CARGO_BUILD_JOBS=2
set NEXT_TELEMETRY_DISABLED=1
set "PATH=%USERPROFILE%\.cargo\bin;%PATH%"

if not exist node_modules (
    echo [1/2] Installing frontend dependencies with pnpm...
    call pnpm install
) else (
    echo [1/2] node_modules found, skipping re-install.
)

echo [2/2] Starting Tauri in OpenBLAS CPU mode (Jobs: 2)...
call pnpm run tauri:dev:openblas
