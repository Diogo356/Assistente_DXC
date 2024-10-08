function domain_remove {
    param(
    )
    $domainAdminUsername = Read-Host "Digite seu nome de usuário do domínio"
    $securePassword = Read-Host -AsSecureString "Digite sua senha"
    
    $credential = New-Object System.Management.Automation.PSCredential($domainAdminUsername, $securePassword)
    if ($computerInfo.PartOfDomain) {
        try {
            Remove-Computer -Credential $credential -Force -Restart
        } catch {
            Write-Host "Erro ao remover a máquina do domínio: $_"
        }
    } else {
        Write-Host "A máquina não está no domínio. Nenhuma ação necessária."
    }
    Start-Sleep -Seconds 60
    if ($computerInfo.PartOfDomain) {
        Restart-Computer -Force
    }
}