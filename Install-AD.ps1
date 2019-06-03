#Install Active Directory

#region Parameter
[CmdletBinding()]
Param
(
     # DomainName
    [Parameter(Mandatory=$true,
               ValueFromPipelineByPropertyName=$true,
               Position=0)]
    [String]$DomainName,
 

    # SafeModeAdministratorPassword
    [Parameter(Mandatory=$true,
               ValueFromPipelineByPropertyName=$true,
               Position=1)]
    [String]$SafeModeAdministratorPassword

)
#endregion

$DeploymentStartDate = Get-Date    
Write-Output "Depoyment started at $DeploymentStartDate"

#region Install Domain
$LocalAdminPWord = ConvertTo-SecureString –String "$localAdminPassword" –AsPlainText -Force
   
#install AAD Feature
Install-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools

#Create Domain
Install-ADDSForest -CreateDnsDelegation:$false -DomainName $DomainName -SkipPreChecks -SafeModeAdministratorPassword $SafeModeAdministratorPassword -InstallDns -Confirm:$false 
#-DatabasePath "E:\NTDS" -SysvolPath "E:\SYSVOL" -LogPath "E:\Logs"

$DeploymentStopDate = Get-Date    
Write-Output "Depoyment stoped at $DeploymentStopDate"