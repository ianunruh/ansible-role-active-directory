# ansible-role-active-directory

This role deploys an Active Directory domain controller using `Install-ADDSForest`.

## Requirements

Tested on Windows Server 2012 R2 with Windows Remote Management (WinRM) enabled.

## Role variables

It is required to set the following variables for this role.

```yaml
ad_domain_name: contoso.com
ad_safe_mode_password: FtPX38qhuaHTaTS4CkZ6Fpsgg5wL883N
```
