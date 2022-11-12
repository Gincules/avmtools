function Get-AvmRoutingSpecificEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmRoutingSpecificEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmRoutingSpecificEntry
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmRoutingSpecificEntry
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
        [ValidateNotNullOrEmpty()]
        [System.String]$NewDestIPAddress,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewDestSubnetMask,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewSourceIPAddress,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewSourceSubnetMask
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:Layer3Forwarding:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/layer3forwarding"
        $avmWebrequestBody.Action = "GetSpecificForwardingEntry"
        $avmWebrequestBody.InnerBody = @"
<s:NewDestIPAddress>{0}</s:NewDestIPAddress>
<s:NewDestSubnetMask>{1}</s:NewDestSubnetMask>
<s:NewSourceIPAddress>{2}</s:NewSourceIPAddress>
<s:NewSourceSubnetMask>{3}</s:NewSourceSubnetMask>
"@ -f $NewDestIPAddress, $NewDestSubnetMask, $NewSourceIPAddress, $NewSourceSubnetMask
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