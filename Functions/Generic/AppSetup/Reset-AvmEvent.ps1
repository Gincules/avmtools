function Reset-AvmEvent {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Reset-AvmEvent
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Reset-AvmEvent
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Reset-AvmEvent
    #>

    Param
    (
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$Insecure = $false,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]$RemoteAccess= $false,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$Url,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$Port,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory=$true)]
        [ValidateRange(0,4294967295)]
        [System.Uint32]$NewEventId
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
        $avmWebrequestBody.UrlPath = "/upnp/control/x_appsetup"
        $avmWebrequestBody.Action = "ResetEvent"
        $avmWebrequestBody.InnerBody = "<s:NewEventId>{0}</s:NewEventId>" -f $NewEventId
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