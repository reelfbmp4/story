@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

title Rename 2 Characters

echo =========================
echo PREVIEW
echo =========================
echo.

set /a count=0
set "error=0"

for %%F in (*) do (
    if /I not "%%~nxF"=="%~nx0" (
        set "old=%%~nxF"
        set "name=%%~nF"
        set "ext=%%~xF"
        set "new=!name:~0,2!!ext!"

        set /a count+=1
        set "OLD_!count!=!old!"
        set "NEW_!count!=!new!"
        set "TMP_!count!=__TMP__!count!!ext!"

        echo !old!  -->  !new!

        set "k=!new:.=_!"
        if defined CHECK_!k! set error=1
        set "CHECK_!k!=1"
    )
)

if %count%==0 (
    echo Khong co file nao.
    pause
    exit
)

if %error%==1 (
    echo.
    echo Loi: Co file bi trung ten sau khi doi.
    pause
    exit
)

echo.
set /p ok=Tien hanh doi ten? (Y/N): 
if /I not "%ok%"=="Y" exit

:: Bước 1: đổi sang tên tạm
for /L %%i in (1,1,%count%) do (
    ren "!OLD_%%i!" "!TMP_%%i!"
)

:: Bước 2: đổi sang tên cuối
for /L %%i in (1,1,%count%) do (
    ren "!TMP_%%i!" "!NEW_%%i!"
)

echo.
echo Da doi ten %count% file thanh cong.
pause