function Deny-AvmHostFilterWanAccessByIp {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Deny-AvmHostFilterWanAccessByIp
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Deny-AvmHostFilterWanAccessByIp
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Deny-AvmHostFilterWanAccessByIp
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
        [System.String]$NewIPv4Address,

        [Parameter()]
        [System.SByte][System.Boolean]$NewDisallow = 0
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_HostFilter:1"
        $avmWebrequestBody.UrlPath = "/upnp/control/x_hostfilter"
        $avmWebrequestBody.Action = "DisallowWANAccessByIP"
        $avmWebrequestBody.InnerBody = @"
<s:NewIPv4Address>{0}</s:NewIPv4Address>
<s:NewDisallow>{1}</s:NewDisallow>
"@ -f $NewIPv4Address, $NewDisallow
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