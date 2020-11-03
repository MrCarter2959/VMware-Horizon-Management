<#
    .SYNOPSIS
        Backup's UAG Appliances

    .DESCRIPTION
        Uses UAG's API and backs up settings and configurations

    .REVISION 
        1.0

    .UPDATED
        1.0 - 11/03/2020 - Initial Creation

    .Author
        Name       : csema2959

    .PARAMETER uagDNSName
        Enter your UAG Appliance DNS Name

    .PARAMETER UAGConfigurationType
        Choose what type of backup you want

    .PARAMETER ExportFullPath
        Enter the full path where you want the export to be store. Do not include the file extension such as .json/.ini

    .PARAMETER Username
        Enter the username to authenticate to the UAG

    .PARAMETER Password
        Enter the password for the username above

    .EXAMPLE 01
        Invoke-UAGBackup -uagDNSName "uag-test.domain.org" -UAGConfigurationType JSON -ExportFullPath "C:\export" -Username "username" -Password "password"

    .EXAMPLE 02
        $uagArray = @(
            "uag-01.domain.org"
            "uag-02.domain.org"
        )
    
        foreach ($uag in $uagArray)
            {
                Invoke-UAGBackup -uagDNSName $uag -UAGConfigurationType JSON -ExportFullPath "C:\$($uag)" -Username "usename" -Password "password"
            }

#>

Function Invoke-UAGBackup {
####################################
# Set Parameters
param (
    [Parameter (Mandatory = $true)]
    [string] $uagDNSName,
    [ValidateSet("JSON","INI")]
    [string] $UAGConfigurationType,
    [string] $ExportFullPath,
    [string] $Username,
    [string] $Password
)

####################################
# Create Authentication String
$uagCredential = "$($Username):$($Password)"

####################################
# Encode Authentication String
$uagEncodedCredentials = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($uagCredential))

####################################
# Create Headers
$uagHeaders = @{
    Authorization = "Basic $uagEncodedCredentials"
}

####################################
# Invoke Backup
Try {
    $uagInvoke = Invoke-WebRequest -Method GET -Headers $uagHeaders -Uri "https://$($uagDNSName):9443/rest/v1/config/settings?format=$($UAGConfigurationType)" -ErrorAction Stop
}
Catch {
    Write-Warning $Error[0]
}

####################################
# Export Backup
Try {
    Switch ($UAGConfigurationType)
        {
            "JSON" {$uagInvoke.Content | Out-File "$($ExportFullPath).json"}
            "INI" {$uagInvoke.Content | Out-File "$($ExportFullPath).ini"}
        }
    }
Catch {
    Write-Warning $Error[0]
}
}