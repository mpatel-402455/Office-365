#Sets the path of where the text file with the list of usernames.
$migrationusers = Get-content -Path D:\MyScripts\Office365\migration_script\migrationusers.txt
#sets the type of license to use, can be changed for PowerBI or other license types
$license ="otnca:ENTERPRISEPACK"
#sets the license type and what to disable
$LO = New-MsolLicenseOptions -AccountSkuId $license -DisabledPlans Deskless, FLOW_O365_P2, POWERAPPS_O365_P2, TEAMS1, PROJECTWORKMANAGEMENT, SWAY, YAMMER_ENTERPRISE, RMS_S_ENTERPRISE, MCOSTANDARD

#the script first removes the Office365 license then adds it back. this helps with users who may or may not have something enabled already and cause error or need for a check

foreach ($migrationuser in $migrationusers)
{
Set-MsolUserLicense -UserPrincipalName $migrationuser@otn.ca -removelicenses otnca:ENTERPRISEPACK
start-sleep -s 2
Set-MsolUserLicense -UserPrincipalName $migrationuser@otn.ca -AddLicense $license -LicenseOptions $LO 

}

<#

ENTERPRISEPACK
ServicePlan
-----------
Deskless - StaffHub
FLOW_O365_P2 - Flow for Office 365
POWERAPPS_O365_P2 - PowerApps for Office 365
TEAMS1 - Microsoft TEAMS
PROJECTWORKMANAGEMENT - Microsoft Planner
SWAY - Sway
INTUNE_O365 - MDM for Office365
YAMMER_ENTERPRISE - Yammer
RMS_S_ENTERPRISE - Azure Rights Management
OFFICESUBSCRIPTION - Office 365 ProPlus 
MCOSTANDARD - Skype for Business (Plan 2)
SHAREPOINTWAC - Office Online
SHAREPOINTENTERPRISE - SharePoint Online (Plan 2)
EXCHANGE_S_ENTERPRISE - Exchange Online (Plan 2) 


#>
