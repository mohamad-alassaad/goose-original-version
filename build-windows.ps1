# Build script for Goose on Windows
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "Step 1: Building Rust backend..." -ForegroundColor Cyan
cargo build --release
if ($LASTEXITCODE -ne 0) { Write-Error "Cargo build failed"; exit 1 }

Write-Host "Step 2: Copying goosed.exe to src/bin..." -ForegroundColor Cyan
Copy-Item "target\release\goosed.exe" "ui\desktop\src\bin\goosed.exe" -Force
if ($LASTEXITCODE -ne 0) { Write-Error "Copy failed"; exit 1 }

Write-Host "Step 3: Packaging Electron app..." -ForegroundColor Cyan
Set-Location "ui\desktop"
pnpm run make
if ($LASTEXITCODE -ne 0) { Write-Error "pnpm make failed"; exit 1 }

Set-Location "..\..\"
Write-Host "Done! Output is in: ui\desktop\out\make\zip\win32\x64\" -ForegroundColor Green
