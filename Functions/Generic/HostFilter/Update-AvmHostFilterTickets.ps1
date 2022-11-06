function Update-AvmHostFilterTickets {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Update-AvmHostFilterTickets
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Update-AvmHostFilterTickets
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Update-AvmHostFilterTickets
    #>

    Param
    (
        [Alias("i")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$Insecure = $false,

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
        [System.Management.Automation.PSCredential]$Credential
    )

    $splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_HostFilter:1#DiscardAllTickets"
        UrlPath = "/upnp/control/x_hostfilter"
        XmlResponse = "DiscardAllTicketsResponse"
    }

    Connect-AvmDevice @splatParameters
}