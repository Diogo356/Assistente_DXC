function menu_add_remove {
    param(
    )
    Clear-Host
    $x= 0
    while ($x -eq 0) {
        Write-Host '       ==========================================='`n -ForegroundColor DarkBlue
        Write-Host '                      MENU DE OPCOES' `n -ForegroundColor White
        Write-Host '       ==========================================='`n -ForegroundColor DarkBlue
        Write-Host '      [1]' -ForegroundColor White -NoNewLine
        Write-Host ' Adicionar No Dominio'`n -ForegroundColor Magenta
        Write-Host '      [2]' -ForegroundColor White -NoNewLine
        Write-Host ' Remover do Dominio'`n -ForegroundColor Magenta
        Write-Host '      [9]' -ForegroundColor White -NoNewLine
        Write-Host ' QUIT'`n -ForegroundColor Magenta

        $option = Read-Host "Escolha uma das Opcoes acima: "

        if ($option -eq 1) {
            domain_add
        } elseif ($option -eq 2) {
            domain_remove
        } elseif ($option -eq 9) {
            $x = 1
            Write-Host "Voltando Para o menu de ferramentas..."
            Start-Sleep(5)
        } else{
            Write-Host "ERROR: A opcao escolhida esta invalida" -ForegroundColor Red
            Write-Host "Escolha somente as opcoes listadas acima"
            Start-Sleep(5)
        }
        Clear-Host
    }
}