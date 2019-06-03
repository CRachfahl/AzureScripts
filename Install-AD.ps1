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

    # localAdminName
    [Parameter(Mandatory=$true,
               ValueFromPipelineByPropertyName=$true,
               Position=1)]
    [String]$localAdminName,

    # localAdminPassword
    [Parameter(Mandatory=$true,
               ValueFromPipelineByPropertyName=$true,
               Position=0)]
    [String]$localAdminPassword

)
#endregion

Get-Date    

#region Install Domain
$LocalAdminPWord = ConvertTo-SecureString –String "$localAdminPassword" –AsPlainText -Force
        
#Create Domain
Install-ADDSForest -CreateDnsDelegation:$false -DomainName $DomainName -SkipPreChecks -SafeModeAdministratorPassword $LocalAdminPWord -InstallDns -Confirm:$false

start-sleep 60

Get-Date