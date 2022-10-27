function Set-AvmVoipCommonCountryCode {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipCommonCountryCode
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipCommonCountryCode
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipCommonCountryCode
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
        [System.String]$NewVoIPCountryCode,

        [Parameter()]
        [System.String]$NewLKZ,

        [Parameter()]
        [System.String]$NewPrefix 
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_VoIP:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_voip"

        if ($Deprecated) {
            $avmWebrequestBody.Action = "SetVoIPCommonCountryCode"
            $avmWebrequestBody.InnerBody = "<s:NewVoIPCountryCode>{0}</s:NewVoIPCountryCode>" -f $NewVoIPCountryCode
        } else {
            $avmWebrequestBody.Action = "X_AVM-DE_SetVoIPCommonCountryCode"
            $avmWebrequestBody.InnerBody = @"
<s:NewX_AVM-DE_LKZ>{0}</s:NewX_AVM-DE_LKZ>
<s:NewX_AVM-DE_LKZPrefix >{1}</s:NewX_AVM-DE_LKZPrefix >
"@ -f $NewLKZ, $NewPrefix 
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

        Connect-AvmDevice @splatParameters
    }
}
