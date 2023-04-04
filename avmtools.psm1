[System.String]$ClassFile = $PSScriptRoot + "\Classes\Generic\AvmClass.ps1"
[System.String]$EnumFile = $PSScriptRoot + "\Enums\Generic\AvmEnum.ps1"

[System.Array]$FunctionFiles = @(
    "${PSScriptRoot}\Functions\Generic\AppSetup.ps1",
    "${PSScriptRoot}\Functions\Generic\Auth.ps1",
    "${PSScriptRoot}\Functions\Generic\Dect.ps1",
    "${PSScriptRoot}\Functions\Generic\DeviceConfig.ps1",
    "${PSScriptRoot}\Functions\Generic\DeviceInfo.ps1",
    "${PSScriptRoot}\Functions\Generic\Filelinks.ps1",
    "${PSScriptRoot}\Functions\Generic\Homeauto.ps1",
    "${PSScriptRoot}\Functions\Generic\Homeplug.ps1",
    "${PSScriptRoot}\Functions\Generic\HostFilter.ps1",
    "${PSScriptRoot}\Functions\Generic\Hosts.ps1",
    "${PSScriptRoot}\Functions\Generic\LANConfigSecurity.ps1",
    "${PSScriptRoot}\Functions\Generic\LANEthernetInterfaceConfig.ps1",
    "${PSScriptRoot}\Functions\Generic\LANHostConfigManagement.ps1",
    "${PSScriptRoot}\Functions\Generic\Layer3Forwarding.ps1",
    "${PSScriptRoot}\Functions\Generic\ManagementServer.ps1",
    "${PSScriptRoot}\Functions\Generic\MyFritz.ps1",
    "${PSScriptRoot}\Functions\Generic\OnTel.ps1",
    "${PSScriptRoot}\Functions\Generic\RemoteAccess.ps1",
    "${PSScriptRoot}\Functions\Generic\Speedtest.ps1",
    "${PSScriptRoot}\Functions\Generic\Storage.ps1",
    "${PSScriptRoot}\Functions\Generic\TAM.ps1",
    "${PSScriptRoot}\Functions\Generic\Time.ps1",
    "${PSScriptRoot}\Functions\Generic\UPnP.ps1",
    "${PSScriptRoot}\Functions\Generic\UserInterface.ps1",
    "${PSScriptRoot}\Functions\Generic\VoIP.ps1",
    "${PSScriptRoot}\Functions\Generic\WANCommonInterfaceConfig.ps1",
    "${PSScriptRoot}\Functions\Generic\WANDSLInterfaceConfig.ps1",
    "${PSScriptRoot}\Functions\Generic\WANDSLLinkConfig.ps1",
    "${PSScriptRoot}\Functions\Generic\WANEthernetLinkConfig.ps1",
    "${PSScriptRoot}\Functions\Generic\WANIPConnection.ps1",
    "${PSScriptRoot}\Functions\Generic\WANPPPConnection.ps1",
    "${PSScriptRoot}\Functions\Generic\WebDAVClient.ps1",
    "${PSScriptRoot}\Functions\Generic\WLANConfiguration.ps1"
)

if (${PSVersionTable}.PSVersion.Major -eq 5) {
    [System.String]$VersionSpecificFunctionFile = $PSScriptRoot + "\Functions\PSVersion5\Connect-AvmDevice.ps1"
} else {
    [System.String]$VersionSpecificFunctionFile = $PSScriptRoot + "\Functions\PSVersion7\Connect-AvmDevice.ps1"
}

if ([System.Environment]::OSVersion.Platform -eq "Win32NT") {
    $ClassFile, $EnumFile, $VersionSpecificFunctionFile | ForEach-Object {
        . $PSItem
    }

    foreach ($FunctionFile in $FunctionFiles) {
        . $FunctionFile
    }
} else {
    $ClassFile, $EnumFile, $VersionSpecificFunctionFile | ForEach-Object {
        . $PSItem.Replace("\","/")
    }

    foreach ($FunctionFile in $FunctionFiles) {
        . $FunctionFile.Replace("\","/")
    }
}