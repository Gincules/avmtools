function Add-AvmLayer3ForwardingEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Add-AvmLayer3ForwardingEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Add-AvmLayer3ForwardingEntry
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Add-AvmLayer3ForwardingEntry
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
        [System.String]$NewType,

        [Parameter()]
        [System.Net.IPAddress]$NewDestIPAddress,

        [Parameter()]
        [System.Net.IPAddress]$NewDestSubnetMask,

        [Parameter()]
        [System.Net.IPAddress]$NewSourceIPAddress,
        
        [Parameter()]
        [System.Net.IPAddress]$NewSourceSubnetMask,

        [Parameter()]
        [System.Net.IPAddress]$NewGatewayIPAddress,

        [Parameter()]
        [System.String]$NewInterface,

        [Parameter()]
        [System.String]$NewForwardingMetric
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:Layer3Forwarding:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/layer3forwarding"
        $avmWebrequestBody.Action = "AddForwardingEntry"
        $avmWebrequestBody.InnerBody = @"
<s:NewType>{0}</s:NewType>
<s:NewDestIPAddress>{1}</s:NewDestIPAddress>
<s:NewDestSubnetMask>{2}</s:NewDestSubnetMask>
<s:NewSourceIPAddress>{3}</s:NewSourceIPAddress>
<s:NewSourceSubnetMask>{4}</s:NewSourceSubnetMask>
<s:NewGatewayIPAddress>{5}</s:NewGatewayIPAddress>
<s:NewInterface>{6}</s:NewInterface>
<s:NewForwardingMetric>{7}</s:NewForwardingMetric>
"@ -f $NewType, $NewDestIPAddress, $NewDestSubnetMask, $NewSourceIPAddress, $NewSourceSubnetMask, $NewGatewayIPAddress, $NewInterface, $NewForwardingMetric
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