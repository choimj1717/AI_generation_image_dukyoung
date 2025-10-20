{\rtf1\ansi\ansicpg949\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 @echo off\
rem ==========================================================\
rem setup_and_run_html.bat\
rem \uc0\u51088 \u46041 \u51004 \u47196  DYAI.zip\u51012  \u54400 \u44256 , \u54596 \u50836 \u54620  \u54872 \u44221 \u51012  \u49884 \u46020  \u49444 \u52824 \u54620  \u46244 \
rem HTML \uc0\u54028 \u51068 \u51012  \u48148 \u47196  \u49892 \u54665 (\u46608 \u45716  \u47196 \u52972  \u49436 \u48260 \u47196  \u51228 \u44277 )\u54644  \u51469 \u45768 \u45796 .\
rem \uc0\u49324 \u50857 : \u51060  \u48176 \u52824 \u54028 \u51068 \u44284  DYAI.zip \u51012  \u44057 \u51008  \u54260 \u45908 \u50640  \u45347 \u44256  \u45908 \u48660 \u53364 \u47533 \
rem ==========================================================\
\
setlocal EnableDelayedExpansion\
\
n:: \uc0\u49444 \u51221 \u44050 \
set "ZIPNAME=DYAI.zip"\
set "OUTDIR=%~dp0DYAI_extracted"\
set "PORT=8000"\
\
necho ----------------------------------------------------------\
necho \uc0\u51088 \u46041  \u49444 \u52824 \'b7\u49892 \u54665  \u49828 \u53356 \u47549 \u53944 \
echo ----------------------------------------------------------\
\
n:: 1) ZIP \uc0\u51316 \u51116  \u54869 \u51064 \
nif not exist "%~dp0%ZIPNAME%" (\
    echo \uc0\u50724 \u47448 : "%ZIPNAME%" \u54028 \u51068 \u51012  \u51060  \u54260 \u45908 \u50640  \u46160 \u44256  \u49892 \u54665 \u54616 \u49464 \u50836 .\
    pause\
    exit /b 1\
)\
\
n:: 2) \uc0\u50517 \u52629  \u54644 \u51228  (PowerShell Expand-Archive \u49324 \u50857 )\
necho \uc0\u50517 \u52629 \u51012  \u54409 \u45768 \u45796 : %ZIPNAME% -> %OUTDIR%\
if not exist "%OUTDIR%" mkdir "%OUTDIR%"\
powershell -NoLogo -NoProfile -Command "Try \{ Expand-Archive -Force -LiteralPath '%~dp0%ZIPNAME%' -DestinationPath '%OUTDIR%'; exit 0 \} Catch \{ exit 1 \}"\
if errorlevel 1 (\
    echo PowerShell\uc0\u47196  \u50517 \u52629 \u54644 \u51228  \u49892 \u54056 . tar \u49884 \u46020 ...\
    if not exist "%OUTDIR%" mkdir "%OUTDIR%"\
    tar -xf "%~dp0%ZIPNAME%" -C "%OUTDIR%" 2>nul\
    if errorlevel 1 (\
        echo \uc0\u51088 \u46041  \u50517 \u52629  \u54644 \u51228  \u47784 \u46160  \u49892 \u54056 \u54664 \u49845 \u45768 \u45796 . \u49688 \u46041 \u51004 \u47196  \u50517 \u52629 \u51012  \u54392 \u49464 \u50836 .\
        pause\
        exit /b 1\
    )\
)\
\
n:: 3) HTML \uc0\u54028 \u51068  \u44160 \u49353  (index.html \u50864 \u49440 )\
necho HTML \uc0\u54028 \u51068 \u51012  \u52286 \u49845 \u45768 \u45796 ...\
set "FIRSTHTML="\
for /f "delims=" %%F in ('dir /b /s "%OUTDIR%\\index.html" 2^>nul') do (\
    set "FIRSTHTML=%%F"\
    goto :found\
)\
for /f "delims=" %%F in ('dir /b /s "%OUTDIR%\\*.html" 2^>nul') do (\
    set "FIRSTHTML=%%F"\
    goto :found\
)\
:found\
if not defined FIRSTHTML (\
    echo \uc0\u54644 \u45817  \u50517 \u52629 \u54028 \u51068 \u50640 \u49436  HTML \u54028 \u51068 \u51012  \u52286 \u51012  \u49688  \u50630 \u49845 \u45768 \u45796 .\
    echo %OUTDIR% \uc0\u54260 \u45908 \u47484  \u54869 \u51064 \u54616 \u49464 \u50836 .\
    pause\
    exit /b 1\
)\
echo \uc0\u52286 \u51008  HTML: !FIRSTHTML!\
\
n:: 4) Python\uc0\u51060  \u51080 \u45716 \u51648  \u54869 \u51064 \u54644 \u49436  \u47196 \u52972  \u49436 \u48260 \u47196  \u49436 \u48708 \u49828 \u54616 \u44144 \u45208 , \u50630 \u45796 \u47732  \u51649 \u51217  \u54028 \u51068  \u50724 \u54536 \
nwhere python >nul 2>&1\
if %errorlevel%==0 (\
    echo Python\uc0\u51060  \u49444 \u52824 \u46104 \u50612  \u51080 \u49845 \u45768 \u45796 . \u44036 \u45800 \u54620  HTTP \u49436 \u48260 \u47484  \u46916 \u50881 \u45768 \u45796  (\u54252 \u53944  %PORT%).\
    rem \uc0\u49345 \u45824 \u44221 \u47196  \u44228 \u49328 : FIRSTHTML\u50640 \u49436  OUTDIR\\ \u48512 \u48516 \u51012  \u51228 \u44144 \
    set "REL=!FIRSTHTML:%OUTDIR%\\=%"\
    set "REL=!REL:\\=/!"\
    pushd "%OUTDIR%"\
    rem \uc0\u49352  \u52285 \u50640 \u49436  http.server \u49892 \u54665 \
    start "LocalServer" cmd /k "python -m http.server %PORT%"\
    timeout /t 1 >nul\
    rem \uc0\u48652 \u46972 \u50864 \u51200 \u47196  \u51217 \u49549  (\u49345 \u45824 \u44221 \u47196 \u44032  \u47336 \u53944 \u46972 \u47732  / \u47196  \u51217 \u49549 )\
    if "!REL!"=="" (\
        start "" "http://localhost:%PORT%/"\
    ) else (\
        start "" "http://localhost:%PORT%/!REL!"\
    )\
    popd\
    echo \uc0\u50756 \u47308 : \u48652 \u46972 \u50864 \u51200 \u44032  \u50676 \u47160 \u49845 \u45768 \u45796 .\
    exit /b 0\
) else (\
    echo Python\uc0\u51060  \u49444 \u52824 \u46104 \u50612  \u51080 \u51648  \u50506 \u49845 \u45768 \u45796 .\
    \
    rem winget\uc0\u47196  Python \u49444 \u52824  \u49884 \u46020  \u50504 \u45236 \
    where winget >nul 2>&1\
    if %errorlevel%==0 (\
        echo winget\uc0\u51060  \u44048 \u51648 \u46104 \u50632 \u49845 \u45768 \u45796 . Python\u51012  \u51088 \u46041  \u49444 \u52824 \u54616 \u47140 \u47732  Y\u47484  \u45572 \u47476 \u49464 \u50836  (\u44288 \u47532 \u51088  \u44428 \u54620  \u54596 \u50836 \u54624  \u49688  \u51080 \u51020 ).\
        set /p "CHOICE=Python \uc0\u49444 \u52824  \u49884 \u46020 ? [Y/N]: "\
        if /i "%CHOICE%"=="Y" (\
            echo winget\uc0\u51012  \u53685 \u54644  Python \u49444 \u52824 \u47484  \u49884 \u46020 \u54633 \u45768 \u45796 . \u44288 \u47532 \u51088  \u44428 \u54620 \u51012  \u50836 \u44396 \u54624  \u49688  \u51080 \u49845 \u45768 \u45796 ...\
            winget install --exact --id Python.Python || (echo winget \uc0\u49444 \u52824  \u49892 \u54056  \u54841 \u51008  \u51473 \u45800 \u46120 )\
            echo \uc0\u49444 \u52824 \u44032  \u45149 \u45212  \u46244  \u45796 \u49884  \u51060  \u48176 \u52824 \u54028 \u51068 \u51012  \u49892 \u54665 \u54616 \u49464 \u50836 .\
            pause\
            exit /b 0\
        )\
    ) else (\
        echo winget\uc0\u51060  \u49444 \u52824 \u46104 \u50612  \u51080 \u51648  \u50506 \u50500  \u51088 \u46041  \u49444 \u52824 \u44032  \u48520 \u44032 \u54633 \u45768 \u45796 .\
    )\
    rem Python\uc0\u51060  \u50630 \u45796 \u47732  HTML \u54028 \u51068 \u51012  \u44592 \u48376  \u48652 \u46972 \u50864 \u51200 \u47196  \u51649 \u51217  \u50672 \u45796 .\
    echo \uc0\u44592 \u48376  \u48652 \u46972 \u50864 \u51200 \u47196  \u51649 \u51217  HTML \u54028 \u51068 \u51012  \u50685 \u45768 \u45796 ...\
    start "" "!FIRSTHTML!"\
    echo \uc0\u50756 \u47308 : \u48652 \u46972 \u50864 \u51200 \u44032  \u50676 \u47160 \u49845 \u45768 \u45796 . \u47196 \u52972  \u50937 \u49436 \u48260 \u44032  \u54596 \u50836 \u54616 \u47732  Python\u51012  \u49444 \u52824 \u54616 \u49464 \u50836 .\
    exit /b 0\
)\
\
n:: \uc0\u50504 \u51204  \u51333 \u47308 \
endlocal\
exit /b 0}