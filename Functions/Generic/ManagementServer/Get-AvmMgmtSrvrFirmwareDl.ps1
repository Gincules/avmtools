function Get-AvmMgmtSrvrFirmwareDl {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmMgmtSrvrFirmwareDl
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmMgmtSrvrFirmwareDl
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmMgmtSrvrFirmwareDl
    #>

    Param
    (
        [Alias("i")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$Insecure = $false,

        [Alias("r")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$RemoteAccess = $false,

        [Alias("u")]
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$Url,

        [Alias("p")]
        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$Port,

        [Alias("c")]
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]$Credential
    )

    [System.Collections.Hashtable]$splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = "urn:dslforum-org:service:ManagementServer:1#X_AVM-DE_GetTR069FirmwareDownloadEnabled"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/mgmsrv"
        XmlResponse = "X_AVM-DE_GetTR069FirmwareDownloadEnabledResponse"
    }

    Connect-AvmDevice @splatParameters
}