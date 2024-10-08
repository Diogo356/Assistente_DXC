function backup {
    param(
    
    )
    $sourcePath = "C:\Users\*"
    $destinationPath = "\\achebr\gru\TI\ServiceDesk\Fazendo_testes"
    $ignoreFilePath = $PSScriptRoot
    $fileName = "ignore.txt"
    $fullName = Join-Path -Path $ignoreFilePath -ChildPath $fileName
    $ignore_list = Get-Content -Path $fullName
    
    if (-not (Test-Path -Path $destinationPath)) {
        Write-Host "Diretorio escolhido nao encontrado"
    }
    
    $directories = Get-ChildItem -Path $sourcePath -Directory | Where-Object { $ignore_list -notcontains $_.Name }
    
    $options = @{}
    
    $count = 1
    foreach ($dir in $directories) {
        $lastModified = $dir.LastWriteTime.ToString("dd/MM/yyyy HH:mm")
        $size = (Get-ChildItem -Path $dir.FullName -Recurse -File | Measure-Object -Property Length -Sum).Sum / 1GB # Tamanho em GB
    
        if ($size -eq $size) {
            $size = 0
        }
        $sizeFormatted = "{0:N2}" -f $size
        Write-Host "[$count] $($dir.Name) - Ultima Modificacao: $lastModified - Tamanho: $sizeFormatted GB"
        $options[$count] = $dir.FullName
        $count++
    }
    
    Write-Host "[0] Sair"
    $choice = Read-Host "Escolha uma opcao"
    
    if ($choice -eq "0") {
        Write-Host "Saindo..."
        exit
    }
    
    if ($options.ContainsKey([int]$choice)) {
        $selectedDir = $options[[int]$choice]
        $destinationDir = Join-Path -Path $destinationPath -ChildPath (Get-Item $selectedDir).Name
        if (-not (Test-Path -Path $selectedDir)) {
            Write-Host "Erro: O caminho '$selectedDir' não existe."
            exit
        }
        if (-not (Test-Path -Path $destinationDir)) {
            New-Item -ItemType Directory -Path $destinationDir
        }
        Get-ChildItem -Path $selectedDir -Directory | Where-Object { $ignore_list -notcontains $_.Name } | ForEach-Object {
            $subDirDestination = Join-Path -Path $destinationDir -ChildPath $_.Name
            if ($_.FullName -ne $subDirDestination) {
                Copy-Item -Path $_.FullName -Destination $subDirDestination -Recurse -Force
                Write-Host "Conteúdo de '$($_.FullName)' copiado para '$subDirDestination'."
            } else {
                Write-Host "Ignorando tentativa de copiar '$($_.FullName)' para si mesmo."
            }
        }
    } else {
        Write-Host "Escolha inválida."
    }
}