function Set-AvmHostAutoWakeOnLanByMac {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmHostAutoWakeOnLanByMac
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmHostAutoWakeOnLanByMac
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmHostAutoWakeOnLanByMac
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
        [System.String]$NewMACAddress,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.SByte][System.Boolean]$NewAutoWOLEnabled
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:Hosts:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/hosts"
        $avmWebrequestBody.Action = "X_AVM-DE_SetAutoWakeOnLANByMACAddress"
        $avmWebrequestBody.InnerBody = @"
<s:NewMACAddress>{0}</s:NewMACAddress>
<s:NewAutoWOLEnabled>{1}</s:NewAutoWOLEnabled>
"@ -f $NewMACAddress, $NewAutoWOLEnabled
    }

    Process {
        [System.Collections.Hashtable]$splatParameters = @{
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