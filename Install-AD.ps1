#Install Active Directory

#region Parameter
[CmdletBinding()]
Param
(
     # DomainName
    [Parameter(Mandatory=$false,
               ValueFromPipelineByPropertyName=$true,
               Position=0)]
    [String]$DomainName ="itcamp.org",

    # SafeModeAdministratorPassword
    [Parameter(Mandatory=$false,
               ValueFromPipelineByPropertyName=$true,
               Position=1)]
    [String]$SafeModeAdministratorPassword = "ADR3setPassword"

)
#endregion

$DeploymentStartDate = Get-Date    
Write-Output "Depoyment started at $DeploymentStartDate"

#region Install Domain
Write-Output "creating $SafeModeAdminPwd SecureSting"
$SafeModeAdministratorPwd = ConvertTo-SecureString -String "$SafeModeAdministratorPassword" -AsPlainText -Force
   
#install AAD Feature
Write-Output "Installing AD-Domain-Service feature"
Install-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools

#Create Domain
Write-Output "Install ADDSForest"
Install-ADDSForest -CreateDnsDelegation:$false -DomainName $DomainName -SkipPreChecks -SafeModeAdministratorPassword $SafeModeAdministratorPwd -InstallDns -Confirm:$false 
#-DatabasePath "E:\NTDS" -SysvolPath "E:\SYSVOL" -LogPath "E:\Logs"

$DeploymentStopDate = Get-Date    
Write-Output "Depoyment stoped at $DeploymentStopDate"