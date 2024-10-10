Import-Module "$PSScriptRoot\..\extras\instalacoes\install_BPC.ps1"
import-Module "$PSScriptRoot\..\extras\instalacoes\install_IBP.ps1"
Import-Module "$PSScriptRoot\..\extras\instalacoes\install_GKO.ps1"
Import-Module "$PSScriptRoot\..\extras\instalacoes\install_APDATA.ps1"


function menu_instalacoes {
    param (
    )
    $x = 0

    while ($x -eq 0) {
        Write-Host '       ================================================================'`n -ForegroundColor DarkBlue
        Write-Host '                      MENU DE OPCOES DE INSTALACOES'`n -ForegroundColor White
        Write-Host '       ================================================================'`n -ForegroundColor DarkBlue
        Write-Host '      [1]' -ForegroundColor White -NoNewLine
        Write-Host ' Instalar O Sap BPC'`n -ForegroundColor Magenta
        Write-Host '      [2]' -ForegroundColor White -NoNewLine
        Write-Host ' Instalar O Sap IBP'`n -ForegroundColor Magenta
        Write-Host '      [3]' -ForegroundColor White -NoNewLine
        Write-Host ' Instalar O ApData'`n -ForegroundColor Magenta
        Write-Host '      [4]' -ForegroundColor White -NoNewLine
        Write-Host ' Instalar O GKO'`n -ForegroundColor Magenta
        Write-Host '      [5]' -ForegroundColor White -NoNewLine
        Write-Host ' Think-Cell'`n`n`n -ForegroundColor Magenta
        Write-Host '      [9]' -ForegroundColor White -NoNewLine
        Write-Host ' SAIR'`n -ForegroundColor Magenta

        $options = Read-Host "Escolha uma das opcoes acima: "
        if ($options -eq 1) {
            install_epm
        } elseif ($options -eq 2) {
            Write-Host "A opcao escolhida foi a de instalacao do IBP"
        } elseif ($options -eq 3) {
            install_apdata
        } elseif ($options -eq 4) {
            shortcut_gko
        } elseif ($options -eq 5) {
            Write-Host "A opcao escolhida foi a de instalacao do Think-Cell"
        } elseif ($options -eq 9) {
            Write-Host "Voce escolheu Sair da opcao de INSTALACOES"
            $x = 1
        } else {
            Write-Host "ERROR: Opcao invalida, Escolha somente as opcoes listadas acima"
        }
        Start-Sleep(3)
        Clear-Host
    }
}