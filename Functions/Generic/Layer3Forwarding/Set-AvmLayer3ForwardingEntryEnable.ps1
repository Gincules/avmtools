function Set-AvmLayer3ForwardingEntryEnable {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmLayer3ForwardingEntryEnable
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmLayer3ForwardingEntryEnable
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmLayer3ForwardingEntryEnable
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
        [System.Net.IPAddress]$NewDestIPAddress,

        [Parameter()]
        [System.Net.IPAddress]$NewDestSubnetMask,

        [Parameter()]
        [System.Net.IPAddress]$NewSourceIPAddress,

        [Parameter()]
        [System.Net.IPAddress]$NewSourceSubnetMask,

        [Parameter()]
        [System.Byte][System.Boolean]$NewEnable
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:Layer3Forwarding:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/layer3forwarding"
        $avmWebrequestBody.Action = "SetForwardingEntryEnable"
        $avmWebrequestBody.InnerBody = @"
<s:NewDestIPAddress>{0}</s:NewDestIPAddress>
<s:NewDestSubnetMask>{1}</s:NewDestSubnetMask>
<s:NewSourceIPAddress>{2}</s:NewSourceIPAddress>
<s:NewSourceSubnetMask>{3}</s:NewSourceSubnetMask>
<s:NewEnable>{4}</s:NewEnable>
"@ -f $NewDestIPAddress, $NewDestSubnetMask, $NewSourceIPAddress, $NewSourceSubnetMask, $NewEnable
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
