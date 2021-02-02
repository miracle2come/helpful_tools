<#
.SYNOPSIS
    Do AD DC test for a replication
.DESCRIPTION
    Create a test user on a random DC
    Wait for 10 seconds
	  Check that a user have been synced to specific DC
    
.PARAMETER serverName
    The testing server name. Needs to filled if the script is not running from the server itself.
.PARAMETER waitingTime
    The amount of time in seconds to wait for AD sync to happen. 600 by default

.EXAMPLE
    Test-DCSync -ServerName TestDCServerName

.NOTES
	version 1.0.0 2020/Dec/14   Kosta Kondaurov       Working version. Tested
  version 0.1.0 2020/Dec/14   Kosta Kondaurov       Initial version
#>

Param(
  [Parameter(Mandatory = $False, Position = 1)]
  [string]$serverName,
    [Parameter(Mandatory = $False, Position = 2)]
  [int]$waitingTime = 600
)

##----------## Init section ##----------##
#Clear-Host
Write-Host "Start DC server sync test"
$AutomaticVariables = Get-Variable
$ThisScript = $MyInvocation

$testOU = 'OU=People,OU=Test,DC=gel,DC=local'


if (!$serverName) {
    $serverName = hostname
}

$dCList =((Get-ADForest).Domains | %{ Get-ADDomainController -Filter * -Server $_ }).name
if ( $dCList -notcontains $servername) {
	Write-Host "The server $serverName is not a Domain Controller" -ForegroundColor Red
	Break
}
$testUserName = "DC_" + $servername + "_test"
$randomDC = $dCList | ? {$_ -ne $servername} | Get-Random

# Script body
Write-Host "The test user name is $testUserName"
New-AdUser -Name $testUserName -Server $randomDC -path $testOU
if (Get-AdUser $testUserName -server $randomDC) {
    Write-Host "test user $testUserName successfully created" -ForegroundColor Green
}
else {
    Write-Host "There is an issue with the test account $testUserName creation on $serverName" -ForegroundColor Red
    Break
}
Get-Date
Write-Host "Waiting for $waitingtime seconds for sync"
Start-sleep -Seconds $waitingtime
Get-date
if (Get-AdUser $testUserName -server $servername) {
	write-host "$serverName test successful. Deleting the test user $testUserName"  -ForegroundColor Green
	Remove-ADUser $testUserName -Confirm:$false
	if (Get-AdUser $testUserName -server $servername) {
		Write-Host -ForegroundColor Red "There is an issue with deleting the test user. Please check manually."
	}
	else {
		Write-Host "The $testUserName have been successfully deleted" -ForegroundColor Green
    }
else {
    Write-Host "Cant find the test user $testUserName . There might be AD sync issue"
    }
}
