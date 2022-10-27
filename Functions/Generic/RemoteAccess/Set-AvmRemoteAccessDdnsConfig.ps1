function Set-AvmRemoteAccessDdnsConfig {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmRemoteAccessDdnsConfig
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmRemoteAccessDdnsConfig
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmRemoteAccessDdnsConfig
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
        [System.Byte][System.Boolean]$NewEnabled,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewProviderName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewUpdateURL,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Net.IPAddress]$NewServerIPv4,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Net.IPAddress]$NewServerIPv6,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewDomain,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]$NewCredential,

        [Parameter(Mandatory)]
        [ValidateSet("ddns_v4","ddns_v6","ddns_both")]
        [System.String]$NewMode
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_RemoteAccess:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_remote"
        $avmWebrequestBody.Action = "SetDDNSConfig"
        $avmWebrequestBody.InnerBody = @"
<s:NewEnabled>{0}</s:NewEnabled>
<s:NewProviderName>{1}</s:NewProviderName>
<s:NewUpdateURL>{2}</s:NewUpdateURL>
<s:NewServerIPv4>{3}</s:NewServerIPv4>
<s:NewServerIPv6>{4}</s:NewServerIPv6>
<s:NewDomain>{5}</s:NewDomain>
<s:NewUsername>{6}</s:NewUsername>
<s:NewPassword>{7}</s:NewPassword>
<s:NewMode>{8}</s:NewMode>
"@ -f $NewEnabled, $NewProviderName, $NewUpdateURL, $NewServerIPv4, $NewServerIPv6, $NewDomain, $NewCredential.GetNetworkCredential().UserName, $NewCredential.GetNetworkCredential().Password, $NewMode
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            SoapAction = $avmWebrequestBody.GenerateSoapAction()
            UrlPath = $avmWebrequestBody.UrlPath
            Body = $avmWebrequestBody.GenerateBody()
            XmlResponse = $avmWebrequestBody.GenerateXmlResponse()
        }

        Connect-AvmDevice @splatParameters
    }
}
