Import-Module "$PSScriptRoot\menus\menu_instalacoes.ps1"
Import-Module "$PSScriptRoot\menus\menu_manutencoes.ps1"
Import-Module "$PSScriptRoot\menus\menu_desinstalacoes.ps1"

function layout {
    Write-Host '      ===================================================================='`n -ForegroundColor White
    Write-Host '          GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG' -ForeGroundColor Magenta
    Write-Host '          GGGGPYYYYYYY55PGGGGG5YYYYPGGGGGGGGG5YYYYPGGGGP55YYYYYYY5GGGG' -ForeGroundColor Magenta
    Write-Host '          GGGG5         .:~JPGY~   :JGGGGGG5~   .?GGY7~.         ?GGGG' -ForeGroundColor Magenta
    Write-Host '          GGGGP????????~:   .7GGJ:   ~YGGP7.   ?PBY~   .~~???????JGGGG' -ForeGroundColor Magenta
    Write-Host '          GGGGGGGGGGGGGGPY~   :PGP7.   ??:   ~5GG7   .?PGGGGGGGGGGGGGG' -ForeGroundColor Magenta
    Write-Host '          GGGGGGGGGGGGGGGGG????YGGG5?.     ~JGGGP????5GGGGGGGGGGGGGGGG' -ForeGroundColor Magenta
    Write-Host '          GGGGGGGGGGGGGGGGGPPPPPGGGB5:     ?GGGGPPPPPGGGGGGGGGGGGGGGGG' -ForeGroundColor Magenta
    Write-Host '          GGGGGGGGGGGGGGGGY:   JGGP7.  .:   ~YGGP~ ..7GGGGGGGGGGGGGGGG' -ForeGroundColor Magenta
    Write-Host '          GGGGG55555555Y?~   .?GG?.   ~5P7.   ~5B5~   :7Y55555555PGGGG' -ForeGroundColor Magenta
    Write-Host '          GGGG5            :7PGJ:   :JGGGG5?    7PGJ~.           ?GGGG' -ForeGroundColor Magenta
    Write-Host '          GGGG5~~~~~~~~~7J5PGGJ~~~~?GGGGGGGGY~~~~?PGGPJ7?~~~~~~~~?GGGG' -ForeGroundColor Magenta
    Write-Host '          GGGGGGGGGGGGGGBBGGGGGGGGGBGGGGGGGGGGGGGGGGGGBGGGGGGGGGGGGGGG'`n -ForeGroundColor Magenta
    Write-Host '      ===================================================================='`n -ForegroundColor White
    Start-Sleep(4)
    Clear-Host
}

function main {
    param(
    )
    $x = 0

    layout
    while ($x -eq 0)
    {
        Write-Host '       =============================================='`n -ForegroundColor DarkBlue
        Write-Host '                      MENU DE Servicos'`n -ForegroundColor White
        Write-Host '       =============================================='`n -ForegroundColor DarkBlue
        Write-Host '      [1]' -ForegroundColor White -NoNewLine
        Write-Host ' INSTALACOES'`n -ForegroundColor Magenta
        Write-Host '      [2]' -ForegroundColor White -NoNewLine
        Write-Host ' MANUTENCOES'`n -ForegroundColor Magenta
        Write-Host '      [3]' -ForegroundColor White -NoNewLine
        Write-Host ' DESINSTALACOES'`n`n`n -ForegroundColor Magenta
        Write-Host '      [9]' -ForegroundColor White -NoNewLine
        Write-Host ' Sair'`n -ForegroundColor Magenta

        $value = Read-Host "Escolha Uma das opcoes acima"
        if ($value -eq 1){
            Clear-Host
           menu_instalacoes
        } elseif ($value -eq 2) {
            Clear-Host
            menu_manutencao
        } elseif ($value -eq 3) {
            Clear-Host
            menu_desinstalacoes
        } elseif ($value -eq 9) {
            Write-Host "Opcao escolhida foi a de sair do programa"
            $x = 1
        }else {
            Write-Host "Opcao invalida, tente novamente"
        }
        Clear-Host
        Start-Sleep(5)
    }
}
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).isInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell -ArgumentList "-File `"$PSCommandPath`"" -Verb RunAs
}


$originalBgColor = $Host.UI.RawUI.BackgroundColor
$originalFgColor = $Host.UI.RawUI.ForegroundColor

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"

# aqui eu chamo a minha funçao main:
main

$Host.UI.RawUI.BackgroundColor = $originalBgColor
$Host.UI.RawUI.ForegroundColor = $originalFgColor