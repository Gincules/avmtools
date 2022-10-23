function Set-AvmManagementFirmwareDownloadEnable {
    <#
        .SYNOPSIS
            Update FRITZ!Box homeplug device
        .DESCRIPTION
            Update FRITZ!Box homeplug device
        .PARAMETER RemoteAccess
            Access FRITZ!Box from the internet
        .PARAMETER Insecure
            Use unencrypted authentication over http instead of https
        .PARAMETER RemoteAccess
            Access FRITZ!Box from the internet
        .PARAMETER Url
            Url of FRITZ!Box
        .PARAMETER Port
            Port of FRITZ!Box
        .PARAMETER Credential
            PSCredential variable
        .PARAMETER a
            Argument list of action SetConfig
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmManagementFirmwareDownloadEnable -RemoteAccess -Url "https://myfritzaddress12.myfritz.net" -Port 443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmManagementFirmwareDownloadEnable -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmManagementFirmwareDownloadEnable -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmManagementFirmwareDownloadEnable -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmManagementFirmwareDownloadEnable -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
    #>

    Param
    (
        [Parameter()]
        [switch]$Insecure = $false,

        [Parameter()]
        [switch]$RemoteAccess = $false,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Url,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [int32]$Port,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [PSCredential]$Credential,

        [Parameter()]
        [switch]$DownloadEnable
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:ManagementServer:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/mgmsrv"
        $avmWebrequestBody.Action = "X_AVM_DE_SetTR069FirmwareDownloadEnabled"
        $avmWebrequestBody.InnerBody = "<s:NewTR069FirmwareDownloadEnabled>{0}</s:NewTR069FirmwareDownloadEnabled>" -f $DownloadEnable

        [System.Xml.XmlNode]$avmBodyParameter = $avmWebrequestBody.GenerateBody()
        [System.String]$soapAction = $avmWebrequestBody.GenerateSoapAction()
        [System.String]$XmlResponse = $avmWebrequestBody.GenerateXmlResponse()
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            Body = $avmBodyParameter
            SoapAction = $soapAction
            UrlPath = $avmWebrequestBody.UrlPath
            XmlResponse = $XmlResponse
        }

        Invoke-AvmAction @splatParameters
    }
}