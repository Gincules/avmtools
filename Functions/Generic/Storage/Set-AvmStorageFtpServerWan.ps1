function Set-AvmStorageFtpServerWan {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmStorageFtpServerWan
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmStorageFtpServerWan
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmStorageFtpServerWan
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

        [Parameter()]
        [System.Byte][System.Boolean]$NewFTPWANEnable = 0,

        [Parameter()]
        [System.Byte][System.Boolean]$NewFTPWANSSLOnly = 0
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Storage:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_storage"
        $avmWebrequestBody.Action = "SetFTPServerWAN"
        $avmWebrequestBody.InnerBody = @"
<s:NewFTPWANEnable>{0}</s:NewFTPWANEnable>
<s:NewFTPWANSSLOnly>{1}</s:NewFTPWANSSLOnly>
"@ -f $NewFTPWANEnable, $NewFTPWANSSLOnly
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

        Invoke-AvmAction @splatParameters
    }
}