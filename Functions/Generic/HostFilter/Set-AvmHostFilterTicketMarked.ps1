function Set-AvmHostFilterTicketMarked {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmHostFilterTicketMarked
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmHostFilterTicketMarked
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmHostFilterTicketMarked
    #>

    <#
        RemoteAccess not working:
        404 Not Found (ERR_NOT_FOUND)404 Not
        FoundERR_NOT_FOUNDWebserver Mon, 17 Oct 2022
        10:10:02 GMT

        needs to be checked if supported
    #>

    Param
    (
        [Alias("i")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$Insecure = $false,

        #[Alias("r")]
        #[Parameter()]
        #[System.Management.Automation.SwitchParameter]$RemoteAccess = $false,

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

    #$splatParameters = @{
    #    Insecure = $Insecure
    #    Url = $Url
    #    Port = $Port
    #    Credential = $Credential
    #    SoapAction = "urn:dslforum-org:service:X_AVM-DE_HostFilter:1#MarkTicket"
    #    UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_hostfilter"
    #    XmlResponse = "MarkTicketResponse"
    #}
    
    $splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_HostFilter:1#MarkTicket"
        UrlPath = "/upnp/control/x_hostfilter"
        XmlResponse = "MarkTicketResponse"
    }
    Connect-AvmDevice @splatParameters
}
