function Set-AvmVoipEnableAreaCode {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipEnableAreaCode
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipEnableAreaCode
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipEnableAreaCode
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
        [System.UInt16]$NewVoIPAccountIndex,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewVoIPEnableAreaCode
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_VoIP:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_voip"
        $avmWebrequestBody.Action = "SetVoIPEnableAreaCode"
        $avmWebrequestBody.InnerBody = @"
<s:NewVoIPAccountIndex>{0}</s:NewVoIPAccountIndex>
<s:NewVoIPEnableAreaCode>{1}</s:NewVoIPEnableAreaCode>
"@ -f $NewVoIPAccountIndex, $NewVoIPEnableAreaCode
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