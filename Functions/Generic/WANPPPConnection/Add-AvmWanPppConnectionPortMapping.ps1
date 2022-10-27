function Add-AvmWanPppConnectionPortMapping {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Add-AvmWanPppConnectionPortMapping
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Add-AvmWanPppConnectionPortMapping
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Add-AvmWanPppConnectionPortMapping
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
        [System.String]$NewPortMappingIndex,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewExternalPort,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewProtocol,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewInternalPort,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewInternalClient,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewEnabled,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewPortMappingDescription,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewLeaseDuration
    )
    
    Begin {
        $avmWebrequestBody = [AvmBody]::new()
    
        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:WANPPPConnection:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/wanpppconn1"
        $avmWebrequestBody.Action = "AddPortMapping"
        $avmWebrequestBody.InnerBody = @"
<s:NewRemoteHost>{0}</s:NewRemoteHost>
<s:NewExternalPort>{1}</s:NewExternalPort>
<s:NewProtocol>{2}</s:NewProtocol>
<s:NewInternalPort>{3}</s:NewInternalPort>
<s:NewInternalClient>{4}</s:NewInternalClient>
<s:NewEnabled>{5}</s:NewEnabled>
<s:NewPortMappingDescription>{6}</s:NewPortMappingDescription>
<s:NewLeaseDuration>{7}</s:NewLeaseDuration>
"@ -f $NewRemoteHost, $NewExternalPort, $NewProtocol, $NewInternalPort, $NewInternalClient, $NewEnabled, $NewPortMappingDescription, $NewLeaseDuration
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
