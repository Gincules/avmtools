function Set-AvmAppVpn {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppVpn
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppVpn
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppVpn
    #>

    Param
    (
        [Alias("i")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$Insecure = $false,

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
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppId,

        [Parameter()]
        [System.String]$NewIPSecIdentifier,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewIPSecPreSharedKey,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]$NewIPSecXauthCredential
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
        $avmWebrequestBody.UrlPath = "/upnp/control/x_appsetup"
        $avmWebrequestBody.Action = "SetAppVPN"
        $avmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewIPSecIdentifier>{1}</s:NewIPSecIdentifier>
<s:NewIPSecPreSharedKey>{2}</s:NewIPSecPreSharedKey>
<s:NewIPSecXauthUsername>{3}</s:NewIPSecXauthUsername>
<s:NewIPSecXauthPassword>{4}</s:NewIPSecXauthPassword>
"@ -f $NewAppId, $NewIPSecIdentifier, $NewIPSecPreSharedKey, $NewIPSecXauthCredential.GetNetworkCredential().UserName, $NewIPSecXauthCredential.GetNetworkCredential().Password
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
