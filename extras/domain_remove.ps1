$domainAdminUsername = Read-Host "Digite seu nome de usuário do domínio"
$securePassword = Read-Host -AsSecureString "Digite sua senha"

$credential = New-Object System.Management.Automation.PSCredential($domainAdminUsername, $securePassword)
try {
    Remove-Computer -Credential $credential -Force
    Start-Sleep -Seconds 60
    Restart-Computer -Force
} catch {
    Write-Host "Erro ao remover a máquina do domínio: $_"
}