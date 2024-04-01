#Requires the GraphAPI Powershell module to be installed and connected
$filepath = FILE
$excelFile = Import-Excel $filepath
$serials = $excelFile | ForEach-Object {
                $_.SerialNumber
                }

ForEach ($Serial in $Serials) {

$deviceRecord = Get-MgDeviceManagementWindowAutopilotDeviceIdentity -Filter "contains(SerialNumber, '$($serial)')"
$deviceID = $deviceRecord.Id
If ($deviceID -eq $null){
    write-host "$Serial not found in Autopilot"}
    else {
    write-host "Deleting Autopilot Records for Serial Number $Serial"
    Remove-MgDeviceManagementWindowAutopilotDeviceIdentity -WindowsAutopilotDeviceIdentityId $deviceID
    }

}
