@echo off

setlocal EnableDelayedExpansion

net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Solicitar permissao de administrador...
    :: Reinicia o script como administrador
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
cls
powershell -command "Write-Host '      ================================================================'`n -ForegroundColor White"
powershell -Command "Write-Host '        GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGGPYYYYYYY55PGGGGG5YYYYPGGGGGGGGG5YYYYPGGGGP55YYYYYYY5GGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGG5         .:~JPGY~   :JGGGGGG5~   .?GGY7~.         ?GGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGGP????????~:   .7GGJ:   ~YGGP7.   ?PBY~   .~~???????JGGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGGGGGGGGGGGGPY~   :PGP7.   ??:   ~5GG7   .?PGGGGGGGGGGGGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGGGGGGGGGGGGGGG????YGGG5?.     ~JGGGP????5GGGGGGGGGGGGGGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGGGGGGGGGGGGGGGPPPPPGGGB5:     ?GGGGPPPPPGGGGGGGGGGGGGGGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGGGGGGGGGGGGGGY:   JGGP7.  .:   ~YGGP~ ..7GGGGGGGGGGGGGGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGGG55555555Y?~   .?GG?.   ~5P7.   ~5B5~   :7Y55555555PGGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGG5            :7PGJ:   :JGGGG5?    7PGJ~.           ?GGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGG5~~~~~~~~~7J5PGGJ~~~~?GGGGGGGGY~~~~?PGGPJ7?~~~~~~~~?GGGG' -ForeGroundColor Magenta"
powershell -Command "Write-Host '        GGGGGGGGGGGGGGBBGGGGGGGGGBGGGGGGGGGGGGGGGGGGBGGGGGGGGGGGGGGG'`n -ForeGroundColor Magenta"
powershell -command "Write-Host '      ================================================================'`n -ForegroundColor White"
timeout /t 4 > nul
cls


powershell -command "Write-Host '                SEJA BEM VINDO A FERRAMENTA ASSISTENTE DA DXC.'`n -ForegroundColor Green"
powershell -command "Write-Host '      AQUI VOCE IRA ENCONTRAR DIVERSAS SOLUCOES PARA CORRIGIR ANGUNS SOFTWARES.'`n -ForegroundColor Red"
powershell -command "Write-Host '                CONTINUE PARA VER AS SOLUCOES DISPONIVEIS.'`n`n`n -ForegroundColor DarkBlue"
powershell -command "Write-Host '      Se quiser adiantar, pode apertar o enter para continuar...' -Foregroundcolor White "
timeout /t 10 > nul
cls

:menu
    powershell -command "Write-Host '       ================================================================'`n -ForegroundColor DarkBlue"
    powershell -command "Write-Host '                      MENU DE OPCOES DA FERRAMENTA'`n -ForegroundColor White"
    powershell -command "Write-Host '       ================================================================'`n -ForegroundColor DarkBlue"
    powershell -command "Write-Host '      [1]' -ForegroundColor White -NoNewLine"
    powershell -command "Write-Host ' LIMPAR OS TEMPORARIOS (AQUI LIMPA OS DOIS)'`n -BackgroundColor Magenta"
    powershell -command "Write-Host '      [2]' -ForegroundColor White -NoNewLine"
    powershell -command "Write-Host ' MOVER O COMMON PARA A PASTA DO SAP LOGON'`n -ForegroundColor Magenta"
    powershell -command "Write-Host '      [3]' -ForegroundColor White -NoNewLine"
    powershell -command "Write-Host ' OPCOES DE DOMINIO (REMOVER OU COLOCAR MAQUINA NO DOMINIO)'`n -ForegroundColor Magenta"
    powershell -command "Write-Host '      [4]' -ForegroundColor White -NoNewLine"
    powershell -command "Write-Host ' FAZER BACKUP DA MAQUINA'`n`n`n -ForegroundColor Magenta"
    powershell -command "Write-Host '      [9]' -ForegroundColor White -NoNewLine"
    powershell -command "Write-Host ' QUIT'`n -ForegroundColor Magenta"
    set /p "options= Escolha uma das opcoes acima: "
    echo %options%
    timeout /t 4 > nul
    if %options%== 1 (
        call :clean_temp
    ) else if %options%== 2 (
        call :move_common
    ) else if %options%== 3 (
        call :get_rem_add
    ) else if %options%== 4 (
        call :backup_tes
    ) else if %options%== 9 (
        powershell -command "Write-Host 'Voce escolheu encerrar o sistema, Ate mais.... ' -ForeGroundColor White"
        timeout /t 4 > nul
        exit
    ) else (
        powershell -command "Write-Host 'ERROr: Opcao invalida' -ForeGroundColor Red"
        powershell -command "Write-Host 'Tente Novamente usando uma opcao correta' -ForegroundColor DarkBlue"
        timeout /t 4 > nul
    )
    cls
    goto :menu
:fim

:move_common
    set "path_dest=\\achebr\gru\TI\ServiceDesk\"
    set "path_src=C:\Users\%USERNAME%\AppData\Roaming\Sap\"
    set file_path=Common

    for /d %%i in ("%path_src%\*") do (
        if /i "%%~nxi" == "%file_path%" (
            if exist "%path_dest%\%file_path%" (
                rmdir /s /q "%path_dest%\%file_path%"
            )
            timeout /t 4 > nul
            xcopy "%%i" "%path_dest%\%file_path%\" /E /I /Y
            echo Pasta %file_path% copiada para %path_dest%
        )
    )
    timeout /t 4 > nul
    cls
    goto :menu
:fim

:clean_temp
    set path_src_temp=C:\Users\%USERNAME%\AppData\Local\Temp

    for /d %%i in ("%path_src_temp%\*") do (
        rmdir /s /q "%%i"
    )
    for %%i in ("%path_src_temp%\*") do (
        del /q "%%i"
    )
    call :clean_temp2
:fim

:clean_temp2
    set path_src_temp2=C:\Windows\Temp

    for /d %%i in ("%path_src_temp2%\*") do (
        rmdir /s /q "%%i"
    )

    for %%i in ("%path_src_temp2%\*") do (
        del /q "%%i"
    )
    timeout /t 3 > nulc
    cls
    goto :menu
:fim

:get_rem_add
    cls
    powershell -command "Write-Host '      [1]' -ForeGroundColor White -NoNewLine"
    powershell -command "Write-Host ' ADICIONAR NO DOMINIO' -ForeGroundColor Magenta"
    powershell -command "Write-Host '      [2]' -ForeGroundColor White -NoNewLine"
    powershell -command "Write-Host ' REMOVER DO DOMINIO'`n`n`n -ForeGroundColor Magenta"
    powershell -command "Write-host '      [9]' -ForeGround White -NoNewLine"
    powershell -command "Write-host ' SAIR' -ForeGround White"

    set /p "value=Escolha uma das opcoes acima: "
    if %value%== 1 (
        call :domain_add
    ) else if %value%== 2 (
        call :domain_remove
    ) else if %value%== 9 (
        echo Voltando para o menu ...
    ) else (
        echo "ERROR: Opcao invalida, Tente uma das opcoes listadas acima."
        cls
        timeout /t 4 > nul
        goto :get_rem_add
    )
    cls
    timeout /t 4 > nul
:fim

:domain_remove
    set "path_remove=%~dp0"
    powershell.exe -ExecutionPolicy Bypass -File "%path_remove%\extras\domain_remove.ps1"
    cls
    timeout /t 4 > nul
    goto :menu
:fim


:domain_add
    set "path_add=%~dp0"
    powershell.exe -ExecutionPolicy Bypass -File "%path_add%\extras\domain_add.ps1"
    cls
    timeout /t 4 > nul
    goto :menu
:fim

:backup_tes
    set scriptPath=%~dp0
    powershell.exe -ExecutionPolicy Bypass -File "%scriptPath%\extras\backup.ps1"
    pause
    cls
    goto :menu
:fim

pause
