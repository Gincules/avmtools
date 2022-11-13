function Set-AvmMgmtSrvrPeriodicInform {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmMgmtSrvrPeriodicInform
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmMgmtSrvrPeriodicInform
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmMgmtSrvrPeriodicInform
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
        [System.Byte][System.Boolean]$NewPeriodicInformEnable,

        [Parameter(Mandatory)]
        [ValidateRange(0,4294967295)]
        [ValidateNotNullOrEmpty()]
        [System.UInt32]$NewPeriodicInformInterval,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
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
"@ -f $NewPeriodicInformEnable, $NewPeriodicInformInterval, $NewPeriodicInformTime.ToString("yyyy-MM-ddTHH:mm:ss")
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