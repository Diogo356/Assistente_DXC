Import-Module "$PSScriptRoot\..\extras\desinstalacoes\desins_BPC.ps1"

function menu_desinstalacoes {
    param(
    )
    $x = 0
    while ($x -eq 0) {
        
        Write-Host '      ======================================================================'`n -ForegroundColor DarkBlue
        Write-Host '                      MENU DE OPCOES DE DESINSTAlACOES'`n -ForegroundColor White
        Write-Host '      ======================================================================'`n -ForegroundColor DarkBlue
        Write-Host '      [1]' -ForegroundColor White -NoNewLine
        Write-Host ' DESINSTALAR Sap BPC'`n -ForegroundColor Magenta
        Write-Host '      [9]' -ForegroundColor White -NoNewLine
        Write-Host ' SAIR'`n -ForegroundColor Magenta
        
        $options = Read-Host "Escolha uma das Opcoes listadas acima "
        if ($options -eq 1) {
            desins_BPC
        } elseif ($options -eq 9) {
            Write-Host "Saindo do menu de Desinstalacoes"
            $x = 1
        } else{
            Write-Host "ERROR: Opcao invalida, Selecione somente as que estão listadas acima" -ForegroundColor Red
        }
        Start-Sleep(2)
        Clear-Host
    }
}