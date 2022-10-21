function Set-AvmAppMessageFilter {
    <#
        .SYNOPSIS
            Set FRITZ!Box app message filter
        .DESCRIPTION
            Set FRITZ!Box app message filter
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
        .PARAMETER AppId
            Identifier of the app instance the message filter belongs to
        .PARAMETER AppType
            Type of the message filter, eg. “aha_ident” 
        .PARAMETER AppFilter
            A stringlist of filter criteria
            (e.g. “08761 0000444,34:45:12:43:55” for type aha_ident)
            Allowed characters: a-Z,0-9, Space and ,+:-_
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppMessageFilter -RemoteAccess -Url "https://myfritzaddress12.myfritz.net" -Port 443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppMessageFilter -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppMessageFilter -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppMessageFilter -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppMessageFilter -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
    #>

    Param
    (
        [switch]$Insecure = $false,
        [switch]$RemoteAccess = $false,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$AppId,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$AppType,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$AppFilter
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
        $avmWebrequestBody.Action = "SetAppMessageFilter"
        $avmWebrequestBody.InnerBody = @"
<s:AppId>{0}</s:AppId>
<s:Type>{1}</s:Type>
<s:NewEventId>{2}</s:NewEventId>
"@ -f $AppId, $AppType, $AppFilter

        [xml]$avmBodyParameter = $avmWebrequestBody.GenerateBody()
        [string]$soapAction = $avmWebrequestBody.GenerateSoapAction()
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            Body = $avmBodyParameter
            SoapAction = $soapAction
            UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_appsetup"
            XmlResponse = "SetAppMessageFilterResponse"
        }

        Invoke-AvmAction @splatParameters
    }
}