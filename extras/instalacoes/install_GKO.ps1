function install_oracle {
    param (
    )
    $valid_path = Test-Path "C:\app\"
    $path_oracle = "\\achebr\gru\Software(GRU)\oracle\Client_11g\win64_11gr2\client\setup.exe"
    $x = 0

    if($valid_path) {
        Write-Host "Oracle para o GKO já está instalado" -ForegroundColor Green
    } else {
        Write-Host "Analista, forneca o seu primeiro nome para conseguirmos identificar o seu arquivo de resposta e entao configurar o Oracle corretamente ou entao digite sair para voltar a tela de escolha de instalacoes"`n`n -ForegroundColor Cyan
        Write-Host "Caso voce seja um analista e o seu nome esteja dando erro, provavelmente o seu nome nao esteja mapeado em nosso sistema" -ForegroundColor DarkYellow
        Write-Host "Entre em contato com o Analista Diogo Belarmino ou com alguem do Time da DXC que trabalhe na Ache e Relate essa situacao"`n`n -ForegroundColor DarkYellow
        
        while ($x -eq 0) {
            $user = Read-Host "Qual o nome do Analista"
            if($user -eq "bruna") {
                $fileResponse = "$PSScriptRoot\..\Clients\Clients_GKO\client_BrunaGKO.rsp"
                Start-Process -FilePath $path_oracle -ArgumentList "-silent -responseFile $fileResponse -ignorePrereq" -Wait
            } elseif($user -eq "thiago") {
                $fileResponse = "$PSScriptRoot\..\Clients\Clients_GKO\client_ThiagoGKO.rsp"
                Start-Process -FilePath $path_oracle -ArgumentList "-silent -responseFile $fileResponse -ignorePrereq" -Wait
            } elseif ($user -eq "vinicius") {
                $fileResponse = "$PSScriptRoot\..\Clients\Clients_GKO\client_ViniciusGKO.rsp"
                Start-Process -FilePath $path_oracle -ArgumentList "-silent -responseFile $fileResponse -ignorePrereq" -Wait
            } elseif ($user -eq "diogo") {
                $fileResponse = "$PSScriptRoot\..\Clients\Clients_GKO\client_DiogoGKO.rsp"
                Start-Process -FilePath $path_oracle -ArgumentList "-silent -responseFile $fileResponse -ignorePrereq" -Wait
            } elseif($user -eq "sair") {
                $x = 1
            }else {
                Write-Error "Value Invalid"
            }
        }
    }
}




function create_Variable_Sistem {
    param (
    )
    $basePath = "C:\app\"

    $variableFolder = Get-ChildItem -Path $basePath -Directory | Where-Object { $_.Name -match '3' }
    if ($variableFolder) {
        $fullPath = Join-Path -Path $variableFolder.FullName -ChildPath "network\admin\sample\tnsnames.ora"
        [Environment]::SetEnvironmentVariable("TNS_NAME", $fullPath, "Machine")
    } else {
        Write-Host "Pasta não encontrada."
    }
}

function shortcut_gko {
    param (
    )
    $gko = New-Object -ComObject wscript.shell
    $shortcut = $gko.CreateShortcut($env:USERPROFILE + '\Desktop\GKO_Fretes.lnk')
    $shortcut.targetpath = "D:\testes_para\gko\PRScf.exe"
    $shortcut.save()
    install_oracle
}