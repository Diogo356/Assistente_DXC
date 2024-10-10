function domain_add {
    param(
    )
    $domainAdminUsername = Read-Host "Digite seu nome de usuario do dominio"
    $securePassword = Read-Host -AsSecureString "Digite sua senha"
    $credential = New-Object System.Management.Automation.PSCredential($domainAdminUsername, $securePassword)
    $domainName ="achebr.int"
    
    try {
        Add-Computer -DomainName $domainName -Credential $credential -Force -Restart
    } catch {
        Write-Host "Erro ao adicionar a máquina ao dominio: $_"
    }
}