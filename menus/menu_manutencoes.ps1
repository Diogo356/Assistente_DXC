Import-Module "$PSScriptRoot\..\extras\manutencoes\backup.ps1"
Import-Module "$PSScriptRoot\..\extras\manutencoes\clear_temps.ps1"
Import-Module "$PSScriptRoot\..\extras\manutencoes\move_common.ps1"
Import-Module "$PSScriptRoot\menu_add_remove.ps1"

function menu_manutencao {
    param (
    )
    
    $x = 0
    while ($x -eq 0) {
        Write-Host '       ================================================================'`n -ForegroundColor DarkBlue
        Write-Host '                      MENU DE OPCOES DE MANUTENCOES'`n -ForegroundColor White
        Write-Host '       ================================================================'`n -ForegroundColor DarkBlue
        Write-Host '      [1]' -ForegroundColor White -NoNewLine
        Write-Host ' LIMPAR OS TEMPORARIOS (AQUI LIMPA OS DOIS)'`n -ForegroundColor Magenta
        Write-Host '      [2]' -ForegroundColor White -NoNewLine
        Write-Host ' MOVER O COMMON PARA A PASTA DO SAP LOGON'`n -ForegroundColor Magenta
        Write-Host '      [3]' -ForegroundColor White -NoNewLine
        Write-Host ' OPCOES DE DOMINIO (REMOVER OU COLOCAR MAQUINA NO DOMINIO)'`n -ForegroundColor Magenta
        Write-Host '      [4]' -ForegroundColor White -NoNewLine
        Write-Host ' FAZER BACKUP DA MAQUINA'`n`n`n -ForegroundColor Magenta
        Write-Host '      [9]' -ForegroundColor White -NoNewLine
        Write-Host ' QUIT'`n -ForegroundColor Magenta
        Start-Sleep(4)
        
        $option = Read-Host "Escolha uma das opcoes Acima"
        if($option -eq 1){
            clear_temps 
        } elseif ($option -eq 2) {
            move_common
        } elseif ($option -eq 3) {
            menu_add_remove
        } elseif ($option -eq 4) {
            backup
        } elseif($option -eq 9) {
            $x = 1
            Clear-Host
            Write-Host "Voce escolheu sair da ferramenta..."
            Start-Sleep(4)
        } else {
            Clear-Host
            Write-Host "ERROR: Opcao invalida." -ForeGroundColor Red
            Write-Host "Escolha uma das opcoes listada acima" -ForeGroundColor Green
        }
        Start-Sleep(2)
        Clear-Host
    }
}