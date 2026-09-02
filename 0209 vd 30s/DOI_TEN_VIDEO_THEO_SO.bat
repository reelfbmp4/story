@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Rename MP4 by leading number

echo ==========================================
echo   RENAME MP4: leading number before "_"
echo ==========================================
echo.

set /a renamed=0
set /a skipped=0

for %%F in ("*.mp4") do (
    set "base=%%~nF"
    set "first="

    rem Lay phan dung truoc dau _ dau tien
    for /f "tokens=1 delims=_" %%A in ("!base!") do set "first=%%A"

    rem Chi xu ly neu ten file co dau _
    if not "!base!"=="!first!" (
        rem Kiem tra phan dau co phai la so hay khong
        echo(!first!| findstr /r "^[0-9][0-9]*$" >nul
        if not errorlevel 1 (
            if exist "!first!.mp4" (
                echo [SKIP] %%~nxF  --^> !first!.mp4  ^(da ton tai^)
                set /a skipped+=1
            ) else (
                echo [RENAME] %%~nxF  --^> !first!.mp4
                ren "%%~nxF" "!first!.mp4"
                if not errorlevel 1 (
                    set /a renamed+=1
                ) else (
                    echo [ERROR] Khong doi duoc: %%~nxF
                )
            )
        ) else (
            echo [SKIP] %%~nxF  ^(khong bat dau bang so + dau _^)
            set /a skipped+=1
        )
    ) else (
        echo [SKIP] %%~nxF  ^(khong co dau _^)
        set /a skipped+=1
    )
)

echo.
echo ==========================================
echo Hoan tat.
echo Da doi ten: !renamed! file
echo Bo qua:     !skipped! file
echo ==========================================
echo.
pause
endlocal
