@echo off

net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Solicitar permissao de administrador...
    :: Reinicia o script como administrador
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cls
powershell -command "Write-Host '                SEJA BEM VINDO A FERRAMENTA ASSISTENTE DA DXC.'`n -ForegroundColor Green"
powershell -command "Write-Host '      AQUI VOCE IRA ENCONTRAR DIVERSAS SOLUCOES PARA CORRIGIR ANGUNS SOFTWARES.'`n -ForegroundColor Red"
powershell -command "Write-Host '                CONTINUE PARA VER AS SOLUCOES DISPONIVEIS.'`n -ForegroundColor DarkBlue"

timeout /t 4 > nul
cls

:menu                                              
powershell -command "Write-Host '       ================================================================'`n -ForegroundColor DarkBlue"
powershell -command "Write-Host '                      MENU DE OPCOES DA FERRAMENTA'`n -ForegroundColor White"
powershell -command "Write-Host '       ================================================================'`n -ForegroundColor DarkBlue"
powershell -command "Write-Host '      [1]' -ForegroundColor White -NoNewLine"
powershell -command "Write-Host ' LIMPAR OS TEMPORARIOS (AQUI LIMPA OS DOIS)'`n -ForegroundColor Magenta"
powershell -command "Write-Host '      [2]' -ForegroundColor White -NoNewLine"
powershell -command "Write-Host ' MOVER O COMMON PARA A PASTA DO SAP LOGON'`n -ForegroundColor Magenta"
powershell -command "Write-Host '      [3]' -ForegroundColor White -NoNewLine"
powershell -command "Write-Host ' OPCOES DE DOMINIO (REMOVER OU COLOCAR MAQUINA NO DOMINIO)'`n -ForegroundColor Magenta"
powershell -command "Write-Host '      [4]' -ForegroundColor White -NoNewLine"
powershell -command "Write-Host ' FAZER BACKUP DA MAQUINA'`n`n`n -ForegroundColor Magenta"
powershell -command "Write-Host '      [9]' -ForegroundColor White -NoNewLine"
powershell -command "Write-Host ' QUIT'`n -ForegroundColor Magenta"

choice /C 12349 /m "      Escolha uma das opcoes acima:"

echo %errorlevel%
if %errorlevel%== 1 (
    call :clean_temp
) else if %errorlevel%== 2 (
    call :move_common
) else if %errorlevel%== 3 (
    call :domain_add
) else if %errorlevel%== 4 (
    echo Valor escolhido foi o de backup
    timeout /t 3 > nul
    cls
    call :menu
@REM ) else if %errorlevel%== 5 (
@REM     echo executando o script de reparo...
@REM     timeout /t 10 > nul
@REM     call :office_repair
@REM ) 
 else if %errorlevel%== 5 (
    cls
    echo a opcao selecionada foi a de encerrar o programa
    timeout /t 4 > nul
    goto :eof
)

@REM Subs Rotinas, aqui é onde crio minhas funções a serem executadas, ao decorrer do código


@REM sub rotina que funciona para mover a pasta common do caminho da rede para o caminho do SAP LOGON
:move_common
set path_dest=C:\blu\
set path_src=C:\Users\Bruna\testes\projetos
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
call :menu
:fim

@REM sub rotina para limpar o %temp% que fica armazenado em C:\Users\%USERNAME%\AppData\Local\Temp
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

@REM Sub rotina para limpar o temp armazenado no caminho C:\Windows\Temp

:clean_temp2
set path_src_temp2=C:\Windows\Temp

for /d %%i in ("%path_src_temp2%\*") do (
    rmdir /s /q "%%i"
)

for %%i in ("%path_src_temp2%\*") do (
    del /q "%%i"
)
timeout /t 3 > nul
cls
call :menu

@REM aqui vai ser uma sub rotina que irá remover a maquina do dominio
:domain_remove

echo Nome do computador: %COMPUTERNAME%
timeout /t 6 > nul
cls
call :menu
:fim


:domain_add
set my_domain=achebr.int
set adm=abcd
set senha=abcd12345

@REM usando esse netdom eu consigo acessar os serviços de diminio da maquina para então dar o comando join e adc todos os outros parametros inseridos 
netdom join %COMPUTERNAME%  /domain:%my_domain% /userd:%adm% /passwordd:%senha%
cls
set error_value=%errorlevel%

echo %error_value%
@REM faço a verificação de erros, aqui é caso de tudo certo no adição do dominio
@REM No else é caso a adição no dominio de problemas, logo ele da uma descrição da possivel causa e da opções de tentar novamente, ou voltar para o menu de opções
if %errorlevel% == 0 (
    powershell -command "Write-HOST 'MAQUINA ADICIONADA NO DOMINIO ACHEBR.INT' -ForegroundColor Green"
    powershell -command "Write-HOST 'AGUARDE...' -ForgegroundColor Green"
    powershell -command "Write-HOST 'A MAQUINA SERA REINICIADA EM 1 MIN ... ' -ForegroundColor Green"
    shutdown /r /t 60
) else (
    powershell -command "Write-Host 'ERROR: A MAQUINA NAO CONSEGUIU SE CONECTAR NO DOMINIO' -ForegroundColor RED"
    powershell -command "Write-Host 'VERIFIQUE SE A MAQUINA AINDA ESTA NO AD (ACTIVE DIRECTORY): %COMPUTERNAME%' -ForegroundColor RED"
    powershell -command "Write-Host 'CASO NAO ESTEJA, AGUARDE UM MOMENTO E TENTE NOVAMENTE'`n`n`n -ForeGroundColor RED"
    powershell -command "Write-Host 'MOTIVOS QUE OCORREM ESSE ERRO: ' -ForeGroundColor RED"
    powershell -command "Write-Host 'AS VEZES O AD AINDA NAO DESASOCIOU A MAQUINA DO DOMINIO. QUANDO ISSO ACONTECE, VOCE DEVE AGUARDAR UM PERIODO PARA TENTAR ATRELAR A MAQUINA NOVAMENTE O DOMINIO. LEVANDO UM PERIODO DE 10min a 1hr' -ForegroundColor RED"
    timeout /t 4 > nul
    choice /C ABC /m "gostaria de tentar novamente?"
    echo valor do : %errorlevel%
    if %errorlevel% == 1 (
        goto :domain_add
    ) else (
        timeout /t 4 > nul
        cls
        call :menu
    )
)
timeout /t 4 > nul
cls
call :menu
:fim



@REM :office_repair
@REM set "path_office=C:\Users\Bruna\Downloads\Programacao\setup.exe"
@REM set "path_xml=C:\Users\Bruna\testes\projetos\teste.xml"

@REM echo %path_office% teste
@REM timeout /t 5 > nul
@REM powershell -ExecutionPolicy Bypass -File "C:\Users\Bruna\testes\projetos\Get-TimeService.ps1"
@REM if exist %path_office% (
@REM     echo iniciando reparo, AGUARDE...
@REM     timeout /t 6 > nul
@REM     start /wait /%path_office% /repair
@REM ) else (
@REM     echo caminho não ecnotrado
@REM     choice /C 12 /M "Quer tentar novamente? "
@REM     if %errorlevel%== 1(
@REM         cls
@REM         call :office_repair
@REM     ) else (
@REM         call :menu
@REM     )
@REM )

@REM timeout /t 5 > nul
@REM call :menu



pause
