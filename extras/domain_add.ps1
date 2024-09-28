$domainAdminUsername = Read-Host "Digite seu nome de usuário do domínio"
$securePassword = Read-Host -AsSecureString "Digite sua senha"
$credential = New-Object System.Management.Automation.PSCredential($domainAdminUsername, $securePassword)
$domainName = Read-Host "achebr.int"

try {
    Add-Computer -DomainName $domainName -Credential $credential -Force -Restart
} catch {
    Write-Host "Erro ao adicionar a máquina ao domínio: $_"
}