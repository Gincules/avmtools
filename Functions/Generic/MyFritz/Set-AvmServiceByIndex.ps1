function Set-AvmServiceByIndex {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmServiceByIndex
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmServiceByIndex
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmServiceByIndex
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
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory)]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewIndex,

        [Parameter(Mandatory)]
        [System.Byte][System.Boolean]$NewEnabled,

        [Parameter(Mandatory)]
        [System.String]$NewName,

        [Parameter(Mandatory)]
        [System.String]$NewScheme,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$NewPort,

        [Parameter(Mandatory)]
        [System.String]$NewURLPath,

        [Parameter()]
        [ValidateSet("","servicetype_app_camera")]
        [System.String]$NewType,

        [Parameter()]
        [System.Net.IPAddress]$NewIPv4Address,

        [Parameter()]
        [System.Net.IPAddress]$NewIPv6Address,

        [Parameter()]
        [System.Net.IPAddress]$NewIPv6InterfaceID,

        [Parameter()]
        [System.String]$NewMACAddress,

        [Parameter()]
        [System.String]$NewHostName
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
"@ -f $NewIndex, $NewEnabled, $NewName, $NewScheme, $NewPort, $NewURLPath, $NewType, $NewIPv4Address, $NewIPv6Address, $NewIPv6InterfaceID, $NewMACAddress, $NewHostName
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

        Connect-AvmDevice @splatParameters
    }
}
