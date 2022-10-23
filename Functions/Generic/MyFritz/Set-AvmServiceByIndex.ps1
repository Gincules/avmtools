function Set-AvmServiceByIndex {
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
            PS C:\> Set-AvmServiceByIndex -RemoteAccess -Url "https://myfritzaddress12.myfritz.net" -Port 443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmServiceByIndex -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmServiceByIndex -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmServiceByIndex -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmServiceByIndex -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
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
        [string]$Index,

        [Parameter()]
        [string]$Enabled,

        [Parameter()]
        [string]$Name,

        [Parameter()]
        [string]$Scheme,

        [Parameter()]
        [string]$NewPort,

        [Parameter()]
        [string]$Path,

        [Parameter()]
        [string]$Type,

        [Parameter()]
        [string]$Ipv4,

        [Parameter()]
        [string]$Ipv6,

        [Parameter()]
        [string]$Ipv6Interface,

        [Parameter()]
        [string]$MacAddress,

        [Parameter()]
        [string]$HostName
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_MyFritz:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_myfritz"
        $avmWebrequestBody.Action = "SetServiceByIndex"
        $avmWebrequestBody.InnerBody = @"
<s:NewIndex>{0}</s:NewIndex>
<s:NewEnabled>{1}</s:NewEnabled>
<s:NewName>{2}</s:NewName>
<s:NewScheme>{3}</s:NewScheme>
<s:NewPort>{4}</s:NewPort>
<s:NewURLPath>{5}</s:NewURLPath>
<s:NewType>{6}</s:NewType>
<s:NewIPv4Address>{7}</s:NewIPv4Address>
<s:NewIPv6Address>{8}</s:NewIPv6Address>
<s:NewIPv6InterfaceID>{9}</s:NewIPv6InterfaceID>
<s:NewMACAddress>{10}</s:NewMACAddress>
<s:NewHostName>{11}</s:NewHostName>
"@ -f $NewIndex, $NewEnabled, $NewName, $NewScheme, $NewPort, $NewURLPath, $NewType, $NewType, $NewIPv4Address, $NewIPv6Address, $NewIPv6InterfaceID, $NewMACAddress, $NewHostName
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            Body = $avmWebrequestBody.GenerateBody()
            SoapAction = $avmWebrequestBody.GenerateSoapAction()
            UrlPath = $avmWebrequestBody.UrlPath
            XmlResponse = $avmWebrequestBody.GenerateXmlResponse()
        }

        Invoke-AvmAction @splatParameters
    }
}