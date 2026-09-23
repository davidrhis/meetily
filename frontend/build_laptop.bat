@echo off
echo ============================================================
echo Meetily Production Builder (Intel Laptop Optimized)
echo Hardware Target: 2 Cores / 8 GB RAM (CPU OpenBLAS mode)
echo ============================================================

set CARGO_BUILD_JOBS=2
set NEXT_TELEMETRY_DISABLED=1
set "PATH=%USERPROFILE%\.cargo\bin;%PATH%"

if not exist node_modules (
    echo [1/2] Installing frontend dependencies with pnpm...
    call pnpm install
)

echo [2/2] Building production executable (Jobs: 2, OpenBLAS)...
call pnpm run tauri:build:openblas
