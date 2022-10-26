function Get-AvmVoipCommonAreaCode {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmVoipCommonAreaCode
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmVoipCommonAreaCode
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmVoipCommonAreaCode
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
        [System.Management.Automation.PSCredential]$Credential
    )

    Begin {
        if ($Deprecated) {
            $SoapAction = "urn:dslforum-org:service:X_VoIP:1#GetVoIPCommonAreaCode"
            $XmlResponse = "GetVoIPCommonAreaCodeResponse"
        } else {
            $SoapAction = "urn:dslforum-org:service:X_VoIP:1#X_AVM-DE_GetVoIPCommonAreaCode"
            $XmlResponse = "X_AVM-DE_GetVoIPCommonAreaCodeResponse"
        }
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            SoapAction = $SoapAction
            UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_voip"
            XmlResponse = $XmlResponse
        }

        Connect-AvmDevice @splatParameters
    }
}