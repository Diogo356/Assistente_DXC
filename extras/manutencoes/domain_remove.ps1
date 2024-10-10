function domain_remove {
    param(
    )
    $domainAdminUsername = Read-Host "Digite seu nome de usuario do domínio"
    $securePassword = Read-Host -AsSecureString "Digite sua senha"
    
    $credential = New-Object System.Management.Automation.PSCredential($domainAdminUsername, $securePassword)
    if ($computerInfo.PartOfDomain) {
        try {
            Remove-Computer -Credential $credential -Force -Restart
        } catch {
            Write-Host "Erro ao remover a maquina do dominio: $_"
        }
    } else {
        Write-Host "A maquina nao esta no domínio. Nenhuma acao necessaria."
    }
    Start-Sleep -Seconds 60
    if ($computerInfo.PartOfDomain) {
        Restart-Computer -Force
    }
}