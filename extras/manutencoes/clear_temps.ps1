function clear_temps {
    param (
    )
    $path_temp = "C:\Users\$env:USERNAME\AppData\Local\Temp\"
    $path_por_temp = "C:\Windows\Temp"
    $i = 0
    while ($i -lt 100){
        Get-ChildItem -Path $path_temp -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
           Remove-Item $_.FullName -Recurse -ErrorAction SilentlyContinue
        }
        Get-ChildItem -Path $path_por_temp -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
        Remove-Item $_.FullName -Recurse -ErrorAction SilentlyContinue
        }
        Write-Progress -Activity "Search in Progress" -Status "$i% Complete:" -PercentComplete $i
        Start-Sleep -Milliseconds 1
        $i = $i + 1
    }
}
