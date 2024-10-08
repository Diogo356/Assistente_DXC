if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).isInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell -ArgumentList "-File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$path_oracle = "D:\testes_para\oracle\win64_11gr2\client\setup.exe"
$filePath = "C:\Users\$env:USERNAME\oracle_silent_install.rsp"
$logFile = "C:\Users\$env:USERNAME\oracle_install_log.txt"

# Criar o arquivo de resposta
$settings = @"
oracle.install.client.oramtsPortNumber=49152
oracle.install.responseFileVersion=http://www.oracle.com/2007/install/rspfmt_clientinstall_response_schema_v11_2_0
INVENTORY_LOCATION=C:\Program Files\Oracle\Inventory
SELECTED_LANGUAGES=en,pt_BR
ORACLE_HOME=D:\app\$env:USERNAME\product\11.2.0\client_1
ORACLE_BASE=D:\app\$env:USERNAME
oracle.install.client.installType=Administrator
"@

# Salvar o conteúdo no arquivo de resposta
$settings | Out-File -FilePath $filePath -Encoding UTF8

# Montar argumentos de instalação
$arguments = @(
    "/silent", 
    "/responseFile `"$filePath`"", 
    "/log `"$logFile`"" ,
    "-ignoreSysPrereqs",  # Ignorar pré-requisitos do sistema
    "-waitforcompletion",  # Aguardar conclusão da instalação
    "-noconfig"            # Não executar ferramentas de configuração
)

# Executar o instalador do Oracle e capturar erros
try {
    Start-Process -FilePath $path_oracle -ArgumentList $arguments -Wait -NoNewWindow -ErrorAction Stop
    Write-Host "Instalação concluída com sucesso."
} catch {
    Write-Host "Erro durante a instalação: $_"
}
