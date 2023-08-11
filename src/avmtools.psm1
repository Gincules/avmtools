[System.String]$ClassFile = $PSScriptRoot + "\private\classes\AvmClass.ps1"
[System.String]$EnumFile = $PSScriptRoot + "\private\enums\AvmEnum.ps1"

[System.Array]$FunctionFiles = @(
    "${PSScriptRoot}\public\functions\AppSetup.ps1",
    "${PSScriptRoot}\public\functions\Auth.ps1",
    "${PSScriptRoot}\public\functions\Dect.ps1",
    "${PSScriptRoot}\public\functions\DeviceConfig.ps1",
    "${PSScriptRoot}\public\functions\DeviceInfo.ps1",
    "${PSScriptRoot}\public\functions\Filelinks.ps1",
    "${PSScriptRoot}\public\functions\Homeauto.ps1",
    "${PSScriptRoot}\public\functions\Homeplug.ps1",
    "${PSScriptRoot}\public\functions\HostFilter.ps1",
    "${PSScriptRoot}\public\functions\Hosts.ps1",
    "${PSScriptRoot}\public\functions\LANConfigSecurity.ps1",
    "${PSScriptRoot}\public\functions\LANEthernetInterfaceConfig.ps1",
    "${PSScriptRoot}\public\functions\LANHostConfigManagement.ps1",
    "${PSScriptRoot}\public\functions\Layer3Forwarding.ps1",
    "${PSScriptRoot}\public\functions\ManagementServer.ps1",
    "${PSScriptRoot}\public\functions\MyFritz.ps1",
    "${PSScriptRoot}\public\functions\OnTel.ps1",
    "${PSScriptRoot}\public\functions\RemoteAccess.ps1",
    "${PSScriptRoot}\public\functions\Speedtest.ps1",
    "${PSScriptRoot}\public\functions\Storage.ps1",
    "${PSScriptRoot}\public\functions\TAM.ps1",
    "${PSScriptRoot}\public\functions\Time.ps1",
    "${PSScriptRoot}\public\functions\UPnP.ps1",
    "${PSScriptRoot}\public\functions\UserInterface.ps1",
    "${PSScriptRoot}\public\functions\VoIP.ps1",
    "${PSScriptRoot}\public\functions\WANCommonInterfaceConfig.ps1",
    "${PSScriptRoot}\public\functions\WANDSLInterfaceConfig.ps1",
    "${PSScriptRoot}\public\functions\WANDSLLinkConfig.ps1",
    "${PSScriptRoot}\public\functions\WANEthernetLinkConfig.ps1",
    "${PSScriptRoot}\public\functions\WANIPConnection.ps1",
    "${PSScriptRoot}\public\functions\WANPPPConnection.ps1",
    "${PSScriptRoot}\public\functions\WebDAVClient.ps1",
    "${PSScriptRoot}\public\functions\WLANConfiguration.ps1"
)

if (${PSVersionTable}.PSVersion.Major -eq 5) {
    [System.String]$VersionSpecificFunctionFile = $PSScriptRoot + "\public\functions\PSVersion5\Connect-AvmDevice.ps1"
} else {
    [System.String]$VersionSpecificFunctionFile = $PSScriptRoot + "\public\functions\PSVersion7\Connect-AvmDevice.ps1"
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