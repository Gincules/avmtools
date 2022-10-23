function Set-AvmLayer3ForwardingEntryEnable {
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
            PS C:\> Set-AvmLayer3ForwardingEntryEnable -RemoteAccess -Url "https://myfritzaddress12.myfritz.net" -Port 443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmLayer3ForwardingEntryEnable -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmLayer3ForwardingEntryEnable -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmLayer3ForwardingEntryEnable -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmLayer3ForwardingEntryEnable -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
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
        [System.String]$DestIPAddress,

        [Parameter()]
        [System.String]$DestSubnetMask,

        [Parameter()]
        [System.String]$SourceIPAddress,

        [Parameter()]
        [System.String]$SourceSubnetMask,

        [Parameter()]
        [System.String]$Enable
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:Layer3Forwarding:1"
        $avmWebrequestBody.Action = "SetForwardingEntryEnable"
        $avmWebrequestBody.InnerBody = @"
<s:NewDestIPAddress>{0}</s:NewDestIPAddress>
<s:NewDestSubnetMask>{1}</s:NewDestSubnetMask>
<s:NewSourceIPAddress>{2}</s:NewSourceIPAddress>
<s:NewSourceSubnetMask>{3}</s:NewSourceSubnetMask>
<s:NewEnable>{4}</s:NewEnable>
"@ -f $DestIPAddress, $DestSubnetMask, $SourceIPAddress, $SourceSubnetMask, $Enable

        [xml]$avmBodyParameter = $avmWebrequestBody.GenerateBody()
        [string]$soapAction = $avmWebrequestBody.GenerateSoapAction()
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            Body = $avmBodyParameter
            SoapAction = $soapAction
            UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/layer3forwarding"
            XmlResponse = "SetForwardingEntryEnableResponse"
        }

        Invoke-AvmAction @splatParameters
    }
}