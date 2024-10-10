function close_office{
    param (
    )
    Write-Host "Por Favor, Antes de continuar, verifique se as ferramentas do office estao abertas" -ForegroundColor Cyan
    Write-Host "Caso esteja, Consulte o portador no notebook/computador se todos os arquivos estao salvos" -ForegroundColor Cyan
    Write-Host "Só prossiga se o colaborador tiver feito o salvamento dos seus arquivos" -ForegroundColor Red
    $validation = Read-Host "Podemos prosseguir[s][n]"
    $validation.ToLower()
    if ($validation -eq 's' -or $validation -eq 'sim') {
        $officeApps = @("WINWORD", "EXCEL", "POWERPNT", "OUTLOOK")
        
        foreach ($app in $officeApps) {
            Stop-Process -Name $app -Force -ErrorAction SilentlyContinue
        }
        Write-Host "Todas as janelas do Office foram fechadas."
    } elseif ($validation -eq 'n' -or $validation -eq 'nao') {
        Write-Host "Ok, voltando para as opcoes de instalacao" -ForegroundColor Cyan
        Start-Sleep(3)
    } else {
        Write-Host
    }
}


function install_ibp {
    param(
    )
    $path_ibp = "$PSScriptroot\..\instaladores\install_IBP.exe"
    $verify_net = runtime_6

    if ($verify_net -eq 0) {
        Start-Process -FilePath $path_ibp
    }
    
}
function runtime_6 {
    param (
    )
    
    $path_net = "D:\testes_para\sap\windowsdesktop-runtime-6.0.13-win-x64.exe"
    $verify_net = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
    Where-Object { $_.DisplayName -like "*Microsoft Windows Desktop Runtime - 6.0.13*" } | 
    Select-Object DisplayName

    if($verify_net) {
        Write-Host "DotNet 6 ja esta instalado, intalando agora o IBP" -ForegroundColor Green
        return 0
    } else {
        Write-Host "Dotnet 6 nao instalado, estarei fazendo a instalacao para voce ..." -ForegroundColor red
        Start-Process -FilePath $path_net -ArgumentList "/install /quiet /norestart" -Wait
        $verify_net = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
        Where-Object { $_.DisplayName -like "*Microsoft Windows Desktop Runtime - 6.0.13*" } | 
        Select-Object DisplayName
        if($verify_net) {
            Write-Host "Dotnet 6 foi instalado com sucesso, instalando agora o IBP" -ForegroundColor Green
            return 0
        } else {
            Write-Host "Solucoes: `n`n`n"
            Write-Host "Tente instalar ele manualmente pelo caminho: \\achebr\gru\Software(GRU)\SAP IBP 2211\"
            Write-Host "Caso consiga manualmente, por favor reporte esse caso para o Analista Diogo Belarmino Via Teams ou Para algum analista que atua na DXC"
            Write-Host "Se nao conseguir manualmente, segue com as proximas possiveis solucoes `n`n`n"
            Write-Host "Verifique se a maquina esta 100% Atualizada, Verifique no windows update. Caso la esteja apresentando algum problema na atualizacao, siga as seguintes etapas: `n`n"
            Write-Host "- Abra o CMD como Administrador"
            Write-Host "- Cole o seguinte comando: winget upgrade --all "
            Write-Host "-Tente novamente pela ferramenta ou manualmente`n`n"
            Write-Host "Caso nao funcione, Procure algum analista da dxc para te ajudar`n`n`n"
            Read-Host "Pressione enter, para continuar..."
            return 1
        }
    }   
}
