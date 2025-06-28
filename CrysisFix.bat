::CrysisFix by Dubas v1.0
@echo off
chcp 65001 > nul
title CrysisFix v1.0
for /F "Tokens=2*" %%I in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 17300" /V InstallLocation') do set crysis_location=%%J
for /F "Tokens=2*" %%I in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 17330" /V InstallLocation') do set crysisw_location=%%J
:menu
echo.
echo Головне Меню
echo ------------
echo Введіть номер із бажаною опцією та натисніть Enter
echo.
if "%crysis_location%"=="" (
    echo Crysis 2007 не встановлено, або шлях не знайдено!
    echo.
) else (
    echo Crysis 2007
	echo.
    echo [1] Встановити Фікс
    echo [2] Встановити часткову Українську локалізацію від Localize Team
    echo [3] Відкрити папку з грою
    echo.
)
if "%crysisw_location%"=="" (
    echo Crysis Warhead 2008 не встановлено, або шлях не знайдено!
    echo.
) else (
    echo Crysis Warhead 2008
	echo.
    echo [4] Встановити Фікс
    echo [5] Відкрити папку з грою
    echo.
)
set /P input=""
if %input% == 1 (goto crysis_fix)
if %input% == 2 (goto crysis_localization)
if %input% == 3 (goto crysis_open_folder)
if %input% == 4 (goto crysisw_fix)
if %input% == 5 (goto crysisw_open_folder)
echo.
echo ПОМИЛКА! Введіть число від 1 до 5!
goto menu


::Crysis 2007
:crysis_fix
if "%crysis_location%"=="" (
    goto crysis_not_found
)
xcopy "%cd%\data\Bin32" "%crysis_location%\Bin32" /i /y > nul
if errorlevel 1 (
    goto error_found
)
xcopy "%cd%\data\Bin64" "%crysis_location%\Bin64" /i /y > nul
if errorlevel 1 (
    goto error_found
)
if exist "%crysis_location%\Pb" rmdir /s /q "%crysis_location%\Pb"
if exist "%crysis_location%\Bin64\b64.dll" del /f "%crysis_location%\Bin64\b64.dll"
goto fix_message

:crysis_localization
if "%crysis_location%"=="" (
    goto crysis_not_found
)
set DATE_TIME=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%
set DATE_TIME=%DATE_TIME: =0%
if not exist "%crysis_location%\Game\Localized" mkdir "%crysis_location%\Game\Localized"
if exist "%crysis_location%\Game\Localized\english.pak" rename "%crysis_location%\Game\Localized\english.pak" english.pak.%DATE_TIME%.backup
xcopy "%cd%\data\Game\Localized\english.pak" "%crysis_location%\Game\Localized" /i /y > nul
if errorlevel 1 (
    goto error_found
)
goto localization_fix_message

:crysis_open_folder
if "%crysis_location%"=="" (
    goto crysis_not_found
)
echo.
%SystemRoot%\explorer.exe "%crysis_location%"
goto menu

::Crysis Warhead 2008
:crysisw_fix
if "%crysisw_location%"=="" (
    goto crysisw_not_found
)
xcopy "%cd%\data\Bin32" "%crysisw_location%\Bin32" /i /y > nul
if errorlevel 1 (
    goto error_found
)
xcopy "%cd%\data\Bin64" "%crysisw_location%\Bin64" /i /y > nul
if errorlevel 1 (
    goto error_found
)
if exist "%crysisw_location%\Pb" rmdir /s /q "%crysisw_location%\Pb"
if exist "%crysisw_location%\Bin64\b64.dll" del /f "%crysisw_location%\Bin64\b64.dll"
if exist "%crysisw_location%\installers\GamespyComrade" rmdir /s /q "%crysisw_location%\installers\GamespyComrade"
if exist "%crysisw_location%\installers\Pb" rmdir /s /q "%crysisw_location%\installers\Pb"
echo.
echo ---------------------------------------------------------------------------------------------------
echo Виправлення встановлено! Але є ще дещо що потрібно зробити!
echo.
echo Увага!!! Обовязково додайте до параметрів запуску в Steam цей рядок:
echo "%crysisw_location%\Bin64\Crysis.exe" %%command%%
echo.
echo Якщо у Вас спостерігається кліпінг звука (щось постійно клацає в грі)
echo.
echo 1. Зайдіть в налаштування звуку або натисніть на клавіарурі комбінацію win+r та введіть mmsys.cpl
echo 2. Виберіть ваш поточний девайс відтворення звуку та зайдіть в властивості 
echo 3. У вкладці додатково виберіть якість звуку в діапазоні 16-32біт 44100-176400 Hz але не більше
echo ----------------------------------------------------------------------------------------------------
goto menu
goto fix_message

:crysisw_open_folder
if "%crysisw_location%"=="" (
    goto crysisw_not_found
)
echo.
%SystemRoot%\explorer.exe "%crysisw_location%"
goto menu

::Message
:fix_message
echo.
echo ------------------------------
echo Виправлення встановлено!
echo ------------------------------
goto menu

:error_found
echo.
echo ------------------------------
echo Помилка! Щось пішло не так!
echo ------------------------------
goto menu

:crysis_not_found
echo.
echo -------------------------------------------------------
echo Помилка: Crysis 2007 не знайдено
echo -------------------------------------------------------
goto menu

:crysisw_not_found
echo.
echo -------------------------------------------------------
echo Помилка: Crysis Warhead 2008 не знайдено
echo -------------------------------------------------------
goto menu

:localization_fix_message
echo.
echo -------------------------------------------------------
echo Часткову Українську локалізацію успішно встановлено!
echo.
echo Українська версія v 1.57
echo Текст: Deluxeman, VanyaGhost, demydd, kabancheg
echo Текстури: thefir
echo -------------------------------------------------------
goto menu