@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Publish local repo to GitHub (SSH)

REM === CONFIG ===
set "REMOTE_SSH=git@github.com:lesgeeeks/dedicatedServerUnreal.git"

REM --- Checks ---
where git >nul 2>&1 || (echo [ERR] Git non installe. & pause & exit /b 1)
if not exist ".git" (echo [ERR] Ici ce n'est pas un repo Git. Ouvre le terminal dans ton projet. & pause & exit /b 1)

REM --- Test SSH (facultatif mais utile) ---
ssh -T git@github.com 1>nul 2>&1
if errorlevel 1 (
  echo [WARN] SSH pas encore OK (ou pas autorise). On continue quand meme.
) else (
  echo [OK] SSH vers GitHub OK.
)

REM --- Détecter branche courante ---
for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set "BR=%%b"
if /I "%BR%"=="HEAD" set "BR=main"
echo [INFO] Branche locale: %BR%

REM --- Ajouter/maj le remote origin ---
git remote remove origin >nul 2>&1
git remote add origin "%REMOTE_SSH%" || (echo [ERR] remote add a echoue. & pause & exit /b 1)
echo [OK] origin => %REMOTE_SSH%

REM --- Premier push (upstream) ---
git rev-list --count HEAD >nul 2>&1
if errorlevel 1 (
  echo [ERR] Pas de commit local. Fais au moins un commit avant de pousser.
  echo    git add -A ^&^& git commit -m "init"
  pause & exit /b 1
)

echo [INFO] Push vers origin/%BR%...
git push -u origin "%BR%"
if errorlevel 1 (
  echo.
  echo [HINT] Si le repo distant a deja du contenu (README/licence), fais :
  echo    git pull origin %BR% --allow-unrelated-histories
  echo    git push -u origin %BR%
  pause & exit /b 1
)

echo.
echo [OK] Projet publie. Remote: %REMOTE_SSH%, branche: %BR%
pause
