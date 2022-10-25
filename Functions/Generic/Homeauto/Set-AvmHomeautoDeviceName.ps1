function Set-AvmHomeautoDeviceName {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmHomeautoDeviceName
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmHomeautoDeviceName
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmHomeautoDeviceName
    #>

    Param
    (
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$Insecure = $false,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]$RemoteAccess = $false,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$Url,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$Port,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory)][ValidateNotNullOrEmpty()]
        [System.String]$NewAIN,

        [Parameter(Mandatory)][ValidateNotNullOrEmpty()]
        [System.String]$NewDeviceName
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Homeauto:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_homeauto"
        $avmWebrequestBody.Action = "SetDeviceName"
        $avmWebrequestBody.InnerBody = @"
<s:NewAIN>{0}</s:NewAIN>
<s:NewDeviceName>{1}</s:NewDeviceName>
"@ -f $NewAIN, $NewDeviceName
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