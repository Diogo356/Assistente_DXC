# Defina o caminho de origem e o caminho de destino
$sourcePath = "C:\Users\*"  # Altere para o diretório que você deseja listar
$destinationPath = "\\achebr\gru\TI\ServiceDesk\Fazendo_testes"  # Altere para o local onde deseja copiar
$ignoreFilePath = $PSScriptRoot
$fileName = "ignore.txt"
$fullName = Join-Path -Path $ignoreFilePath -ChildPath $fileName
$ignore_list = Get-Content -Path $fullName

# Verifica se o diretório de destino existe, se não, cria
if (-not (Test-Path -Path $destinationPath)) {
    Write-Host "Diretorio escolhido nao encontrado"
}

# Obtém todos os diretórios em $sourcePath, ignorando os listados em $ignore_list
$directories = Get-ChildItem -Path $sourcePath -Directory | Where-Object { $ignore_list -notcontains $_.Name }

# Cria uma lista para opções
$options = @{}

# Exibe os diretórios e armazena suas opções com data de modificação e tamanho
$count = 1
foreach ($dir in $directories) {
    $lastModified = $dir.LastWriteTime.ToString("dd/MM/yyyy HH:mm")
    $size = (Get-ChildItem -Path $dir.FullName -Recurse -File | Measure-Object -Property Length -Sum).Sum / 1GB # Tamanho em GB

    # Verifica se o tamanho não é nulo
    if ($size -eq $size) {
        $size = 0
    }

    # Exibe as informações
    $sizeFormatted = "{0:N2}" -f $size
    Write-Host "[$count] $($dir.Name) - Ultima Modificacao: $lastModified - Tamanho: $sizeFormatted GB"
    $options[$count] = $dir.FullName
    $count++
}

Write-Host "[0] Sair"

# Lê a escolha do usuário
$choice = Read-Host "Escolha uma opcao"

# Se o usuário escolher sair
if ($choice -eq "0") {
    Write-Host "Saindo..."
    exit
}

# Verifica se a escolha é válida
if ($options.ContainsKey([int]$choice)) {
    $selectedDir = $options[[int]$choice]
    $destinationDir = Join-Path -Path $destinationPath -ChildPath (Get-Item $selectedDir).Name

    # Cria o diretório de destino se não existir
    if (-not (Test-Path -Path $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir
    }

    # Copia os diretórios dentro do diretório selecionado, ignorando os listados no ignore_list
    Get-ChildItem -Path $selectedDir -Directory | Where-Object { $ignore_list -notcontains $_.Name } | ForEach-Object {
        $subDirDestination = Join-Path -Path $destinationDir -ChildPath $_.Name

        # Verifica se não está tentando copiar para o mesmo local
        if ($_.FullName -ne $subDirDestination) {
            Copy-Item -Path $_.FullName -Destination $subDirDestination -Recurse -Force
            Write-Host "Conteudo de '$($_.FullName)' copiado para '$subDirDestination'."
        } else {
            Write-Host "Ignorando tentativa de copiar '$($_.FullName)' para si mesmo."
        }
    }
} else {
    Write-Host "Escolha inválida."
}
