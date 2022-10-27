function Get-AvmWlanGlobalEnable {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmWlanGlobalEnable
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmWlanGlobalEnable
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmWlanGlobalEnable
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
        [System.String]$NewWLANGlobalEnable
    )
    
    Begin {
        $avmWebrequestBody = [AvmBody]::new()
    
        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:WLANConfiguration:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/wlanconfig1"
        $avmWebrequestBody.Action = "X_AVM-DE_SetWLANGlobalEnable"
        $avmWebrequestBody.InnerBody = "<s:NewX_AVM-DE_WLANGlobalEnable>{0}</s:NewX_AVM-DE_WLANGlobalEnable>" -f $NewWLANGlobalEnable
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
