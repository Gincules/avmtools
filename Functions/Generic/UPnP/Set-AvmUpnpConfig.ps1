function Set-AvmTimeNtpServer {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmTimeNtpServer
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmTimeNtpServer
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmTimeNtpServer
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
        [ValidateRange(0,65535)]
        [System.UInt16]$NewIndex,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewEnable,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewUPnPMediaServer
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_UPnP:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_upnp"
        $avmWebrequestBody.Action = "SetConfig"
        $avmWebrequestBody.InnerBody = @"
<s:NewEnable>{0}</s:NewEnable>
<s:NewUPnPMediaServer>{1}</s:NewUPnPMediaServer>
"@ -f $NewEnable, $NewUPnPMediaServer
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