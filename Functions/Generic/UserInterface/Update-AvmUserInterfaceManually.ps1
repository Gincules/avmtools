function Update-AvmUserInterfaceManually {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Update-AvmUserInterfaceManually
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Update-AvmUserInterfaceManually
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Update-AvmUserInterfaceManually
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
        [System.String]$NewDownloadURL,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewAllowDowngrade
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:UserInterface:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/userif"
        $avmWebrequestBody.Action = "X_AVM-DE_DoManualUpdate"
        $avmWebrequestBody.InnerBody = @"
<s:NewX_AVM-DE_DownloadURL>{0}</s:NewX_AVM-DE_DownloadURL>
<s:NewX_AVM-DE_AllowDowngrade>{1}</s:NewX_AVM-DE_AllowDowngrade>
"@ -f $NewDownloadURL, $NewAllowDowngrade
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