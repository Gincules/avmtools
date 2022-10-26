function Set-AvmVoipCommonAreaCode {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipCommonAreaCode
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipCommonAreaCode
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipCommonAreaCode
    #>

    Param
    (
        [Alias("i")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$Insecure = $false,

        [Alias("r")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$RemoteAccess = $false,

        [Alias("d")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$Deprecated = $false,

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
        [System.String]$NewVoIPAreaCode,

        [Parameter()]
        [System.String]$NewOKZ,

        [Parameter()]
        [System.String]$NewOKZPrefix
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_VoIP:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_voip"

        if ($Deprecated) {
            $avmWebrequestBody.Action = "SetVoIPCommonAreaCode"
            $avmWebrequestBody.InnerBody = "<s:NewVoIPEnableAreaCode>{0}</s:NewVoIPEnableAreaCode>" -f $NewVoIPAreaCode
        } else {
            $avmWebrequestBody.Action = "X_AVM-DE_SetVoIPCommonAreaCode"
            $avmWebrequestBody.InnerBody = @"
<s:NewX_AVM-DE_OKZ>{0}</s:NewX_AVM-DE_OKZ>
<s:NewX_AVM-DE_OKZPrefix>{1}</s:NewX_AVM-DE_OKZPrefix>
"@ -f $NewOKZ, $NewOKZPrefix
        }
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