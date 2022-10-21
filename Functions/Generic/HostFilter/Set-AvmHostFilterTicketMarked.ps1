function Set-AvmHostFilterTicketMarked {
    <#
        .SYNOPSIS
            Get FRITZ!Box Ticket ID state and set as marked
        .DESCRIPTION
            Returns FRITZ!Box Ticket ID state and set as marked
        .PARAMETER Insecure
            Use unencrypted authentication over http instead of https
        .PARAMETER RemoteAccess
            Access FRITZ!Box from the internet
        .PARAMETER Url
            Url of FRITZ!Box
        .PARAMETER Port
            Port of FRITZ!Box
        .PARAMETER Credential
            PSCredential variable
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmHostFilterTicketMarked -RemoteAccess -Url "https://myfritzaddress12.myfritz.net" -Port 443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmHostFilterTicketMarked -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmHostFilterTicketMarked -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmHostFilterTicketMarked -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmHostFilterTicketMarked -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
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
        [switch]$Insecure = $false,
        #[switch]$RemoteAccess = $false,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential
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