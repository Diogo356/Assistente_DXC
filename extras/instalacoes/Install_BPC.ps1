function install_EPM {
    param (
    )

    $path_epm = "$PSScriptroot\..\instaladores\install_EPM.au3"

    $verify_bpc = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
    Where-Object { $_.DisplayName -like "*SAP Analysis For Microsoft Office*" } | 
    Select-Object DisplayName

    $verify_epm = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
    Where-Object { $_.DisplayName -like "*EPM Add-In*" } | 
    Select-Object DisplayName

    if(($verify_bpc) -and ($verify_epm)) {
        Write-Host "O BPCNW e o EPM-Add-in Ja está instalado" -ForegroundColor Green
        Write-Host "Verificando se o EPM já está instalado ..."
    
    } elseif (($verify_bpc) -and -not($verify_epm)) {
        Write-Host "O Bpc já está instalado"
        Write-Host "Instalando o EPM Add-In ..."
        Start-Process -FilePath $path_epm "/log $PSScriptRoot\..\extras\log_instalation_EPM.txt" -Wait
        $verify_epm = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
        Where-Object { $_.DisplayName -like "*EPM Add-In*" } |
        Select-Object DisplayName
        if (-not($path_epm)) {
            Write-Host "ERROR: Não foi possivel Intalar o EPM Add-In" -ForegroundColor Red
            Write-Host "Verifique o arquivo de log, gerado em Import-Module $PSScriptRoot\..\extras\log_instalation_EPM.txt"
        }
    } else {
        Write-Host "BPCNW e o EPM Add-In Nao estao instalados"
        Write-Host "Começando a instalaçao ..."
        install_BPC
        Start-Process -FilePath $path_epm "/log $PSScriptRoot\log_instalation_EPM.txt" -Wait

        $verify_bpc = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
        Where-Object { $_.DisplayName -like "*SAP Analysis For Microsoft Office*" } | 
        Select-Object DisplayName

        $verify_epm = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
        Where-Object { $_.DisplayName -like "*EPM Add-In*" } | 
        Select-Object DisplayName
        if(($verify_bpc) -and ($verify_epm)) {
            Write-Host "BPC e EPM foram instalados com Sucesso" -ForegroundColor Green
        } else {
            Write-Host "ERROR: Desculpa Não conseguimos instalar o BPC ou o EPM Add-In" -ForegroundColor Red
            Write-Host "Verifique o log de erro gerado nos seguintes caminhos $PSScriptRoot\log_instalation_EPM.txt e $PSScriptRoot\log_instalation_BPC.txt" -ForegroundColor DarkCyan
            Write-Host "Pode ser alguma dependencia que está em falta, ou bloquearam o executavel de instalacao do EPM" -ForegroundColor Red
            Write-Host "Entre em contato com o desenvolvedor da ferramenta para descobrir o motivo" -ForegroundColor Red
        }
    }
}

function install_BPC {
    param (
    )
    $installerPath = "D:\testes_para\sap\AOFFICE28SP15_0-70004973 64bits Atualizado.exe"
    $verifyVs2010 = install_VS2010

    if ($verifyVs2010 -eq 0) {
        Start-Process -FilePath $installerPath -ArgumentList "/silent /components=`"BPC, EPM`"" -Wait -NoNewWindow

        $exitCode = $LASTEXITCODE
        Write-Host "Código de saída da instalação: $exitCode"
        if ($exitCode -eq 0) {
            Write-Host "A instalação do SAP BPC Client foi concluída com sucesso."
        } else {
            Write-Host "A instalação do SAP BPC Client falhou."
        }
    } else {
        Write-Host "O Bpc Não pode ser instalado, por falta de algumas ferramentas"
        Write-Host "Verifique o texto acima e descubra o motivo da instalação estar dando erro."
    }
}

function install_VS2010 {
    param (
    )
    $installVS = "D:\testes_para\sap\vstor_redist.exe"
    
    $vs = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
    Where-Object { $_.DisplayName -like "*Visual Studio 2010 Tools for Office Runtime*" } | 
    Select-Object DisplayName
    
    if ($vs) {
        Write-Host "O Visual Studio 2010 Ja esta instalado, Proseguindo com a instalação do BPC" -ForegroundColor Green
        return 0
    } else {
        Write-Host "O Visual Studio 2010 nao esta instalado, Fazendo a instalacao dele ..." -ForegroundColor Red
        Start-Process -FilePath $installVS -ArgumentList "/quiet" -Wait
        $vs = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
        Where-Object { $_.DisplayName -like "*Visual Studio 2010 Tools for Office Runtime*" } | 
        Select-Object DisplayName
        if($vs) {
            Write-Host "O Visual Studio 2010, foi instalado com exito, Prosseguindo para a instalacao do BPC" -ForeGroundColor Green
            return 0
        } else {
            Write-Host "Desculpe Não conseguimos fazer a instalação do Visual Studio 2010"
            Write-Host "Isso acontece quando o computador não está atualizado"
            Write-Host "Tente Atualizalo pelo windows update, se estiver bugado, pesquise por winget em algum navegador"
            return 1
        }
    }
}