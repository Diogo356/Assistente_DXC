function move_common {
    param (
    )
    $path_src = "\\achebr\gru\TI\ServiceDesk\"
    $path_dest = "C:\Users\$env:USERNAME\AppData\Roaming\Sap\"
    $file = "Common"
    $full_src = Join-Path -Path $path_src -ChildPath $file
    $full_dest = Join-Path -Path $path_dest -ChildPath $file
    
    
    if (Test-Path -Path $full_src) {
        if (Test-Path -Path $full_dest) {
            Write-Host "A pasta Ja existe, Estarei removendo-a para fazer a copia" -ForegroundColor Green
            Remove-Item $full_dest -Recurse
        }
        Copy-Item $full_src $path_dest -Recurse
    } else {
        if (-not (Test-Path -Path $full_src)) {
            Write-Host "O caminho para encontrar a pasta nao existe" -ForeGroundColor Red
        } elseif (-not (Test-Path -Path $full_src)) {
            Write-Host "ERROR: O Caminho de destino nÃ£o existe" -ForeGroundColor Red
        }
    }
    Start-Sleep(5)
}
