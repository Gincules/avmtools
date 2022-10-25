function Set-AvmMangagementServerPeriodicInform {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmMangagementServerPeriodicInform
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmMangagementServerPeriodicInform
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmMangagementServerPeriodicInform
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
        [System.Byte][System.Boolean]$NewPeriodicInformEnable = 0,

        [Parameter()]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPeriodicInformInterval,

        [Parameter()]
        [System.DateTime]$NewPeriodicInformTime
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:ManagementServer:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/mgmsrv"
        $avmWebrequestBody.Action = "SetPeriodicInform"
        $avmWebrequestBody.InnerBody = @"
<s:NewPeriodicInformEnable>{0}</s:NewPeriodicInformEnable>
<s:NewPeriodicInformInterval>{1}</s:NewPeriodicInformInterval>
<s:NewPeriodicInformTime>{2}</s:NewPeriodicInformTime>
"@ -f $NewPeriodicInformEnable, $NewPeriodicInformInterval, $NewPeriodicInformTime
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

        Invoke-AvmAction @splatParameters
    }
}