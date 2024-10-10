function install_apdata {
    param (
    )
    $path_src = "D:\testes_para\APDATA"
    $path_dest = "C:\"

    if(Test-Path $path_src) {
        Write-Host "A pasta APDATA ja existe no local C:\" -ForegroundColor Cyan
        $question = Read-Host "Voce quer fazer uma nova copia[s][n] "
        if(($question -eq 's') -or ($question -eq 'S')) {
            Remove-Item "C:\APDATA" -Recurse
            Write-Host "Pasta deleta, Copiando a Pasta novamente..."
            Start-Sleep(1)
            Copy-Item $path_src $path_dest -Recurse
            Write-Host "A pasta APDATA foi criada No local C:\ Com sucesso" -ForegroundColor Green
            Start-Sleep(1)
            $aptools = New-Object -ComObject wscript.shell
            $apusers = New-Object -ComObject wscript.shell
            $shortcut = $aptools.CreateShortcut($env:USERPROFILE + '\Desktop\ApTools.lnk')
            $shortcut.targetpath = "C:\APDATA\Client\WinUser\ApTools.exe"
            $shortcut.save()
            $shortcut = $apusers.CreateShortcut($env:USERPROFILE + '\Desktop\ApUsers.lnk')
            $shortcut.targetpath = "C:\APDATA\Client\WinUser\ApUsers.exe"
            $shortcut.save()
            Write-Host "Atalhos Criados com sucesso" -ForegroundColor Green
        } else {
            Write-Host "Pasta não copiada novamente" -ForegroundColor Cyan
        }
    } else {
        Copy-Item $path_src $path_dest -Recurse
        Write-Host "A pasta APDATA foi criada No local C:\ Com sucesso" -ForegroundColor Green
        Start-Sleep(2)
        $aptools = New-Object -ComObject wscript.shell
        $apusers = New-Object -ComObject wscript.shell
        $shortcut = $aptools.CreateShortcut($env:USERPROFILE + '\Desktop\ApTools.lnk')
        $shortcut.targetpath = "C:\APDATA\Client\WinUser\ApTools.exe"
        $shortcut.save()
        $shortcut = $apusers.CreateShortcut($env:USERPROFILE + '\Desktop\ApUsers.lnk')
        $shortcut.targetpath = "C:\APDATA\Client\WinUser\ApUsers.exe"
        $shortcut.save()
    }
}
