function Set-AvmSpeedtestConfig {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmSpeedtestConfig
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmSpeedtestConfig
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmSpeedtestConfig
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
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewEnableTcp,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewEnableUdp,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewEnableUdpBidirect,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewWANEnableTcp,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewWANEnableUdp
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Speedtest:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_speedtest"
        $avmWebrequestBody.Action = "SetConfig"
        $avmWebrequestBody.InnerBody = @"
<s:NewEnableTcp>{0}</s:NewEnableTcp>
<s:NewEnableUdp>{1}</s:NewEnableUdp>
<s:NewEnableUdpBidirect>{2}</s:NewEnableUdpBidirect>
<s:NewWANEnableTcp>{3}</s:NewWANEnableTcp>
<s:NewWANEnableUdp>{4}</s:NewWANEnableUdp>
"@ -f $NewEnableTcp, $NewEnableUdp, $NewEnableUdpBidirect, $NewWANEnableTcp, $NewWANEnableUdp
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