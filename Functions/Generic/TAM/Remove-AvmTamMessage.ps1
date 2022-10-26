function Remove-AvmTamMessage {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmTamMessage
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmTamMessage
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmTamMessage
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
        [ValidateRange(0,65535)]
        [System.UInt16]$NewMessageIndex
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_TAM:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_tam"
        $avmWebrequestBody.Action = "DeleteMessage"
        $avmWebrequestBody.InnerBody = @"
<s:NewIndex>{0}</s:NewIndex>
<s:NewMessageIndex>{1}</s:NewMessageIndex>
"@ -f $NewIndex, $NewMessageIndex
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