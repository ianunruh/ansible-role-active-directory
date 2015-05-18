#!powershell

# WANT_JSON
# POWERSHELL_COMMON

$params = Parse-Args $args;

$result = New-Object PSObject -Property @{
    changed = $false
}

If ($params.domain_name) {
    $domainName = $params.domain_name
}
Else {
    Fail-Json $result "missing required argument: domain_name"
}

If ($params.safe_mode_password) {
    $safeModePassword = $params.safe_mode_password
}
Else {
    Fail-Json $result "missing required argument: safe_mode_password"
}

try {
    Import-Module ADDSDeployment
}
catch {
    Fail-Json $result $_.Exception.Message
}

try {
    Get-ADDomainController | Out-Null
    Exit-Json $result
}
catch {
}

$secureSafeModePassword = ConvertTo-SecureString "$safeModePassword" -AsPlainText -Force

try {
  Install-ADDSForest `
      -DomainName "$domainName" `
      -SafeModeAdministratorPassword $secureSafeModePassword `
      -InstallDns:$true `
      -NoRebootOnCompletion:$true `
      -Force:$true

  $result.changed = $true

  Exit-Json $result
}
catch {
  Fail-Json $result $_.Exception.Message
}
