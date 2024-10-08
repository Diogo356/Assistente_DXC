function desins_BPC {
    param (
    )

    $verify_epm = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
    Where-Object { $_.DisplayName -like "*EPM add-in for Microsoft Office*" } |
    Select-Object DisplayName
    $verify_bpc = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
    Where-Object { $_.DisplayName -like "*SAP Analysis For Microsoft Office*" } | 
    Select-Object DisplayName

    if(($verify_bpc) -and ($verify_epm)) {
        Write-Host "O BPC e o EPM Add-In seram desinstalados, aguarde ... " -ForegroundColor Cyan
        $app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "EPM add-in for Microsoft Office" }
        $app.Uninstall()
        $app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "SAP Analysis For Microsoft Office" }
        $app.Uninstall()
    } elseif ($verify_epm) {
        Write-Host "Desinstalando o EPM, Aguarde ... " -ForegroundColor Cyan
        $app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "EPM add-in for Microsoft Office" }
        $app.Uninstall()
    } elseif ($verify_bpc) {
        Write-Host "Desinstalando o BPC, Aguarde ... " -ForegroundColor Cyan
        Start-Process -FilePath "C:\Program Files (x86)\SAP\SAPsetup\setup\NwSapSetup.exe" `
        -ArgumentList '/silent /product="SapCofx64+SapEPMx64" /uninstall /IgnoreMissingProducts' ` -Wait
    } else {
        Write-Host "Estas ferramentas já foram desinstaladas" -ForegroundColor Cyan
        Write-Host "Caso elas ainda permaneçam nesse computador, Entrem em contato com o desenvolvedor responsavel e apresente o caso" -ForegroundColor Cyan
    }
}