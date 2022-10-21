function Set-AvmAppVpnWithPfs {
    <#
        .SYNOPSIS
            Set FRITZ!Box app VPN with PFS
        .DESCRIPTION
            Set FRITZ!Box app VPN with PFS
        .PARAMETER Insecure
            Use unencrypted authentication over http instead of https
        .PARAMETER Url
            Url of FRITZ!Box
        .PARAMETER Port
            Port of FRITZ!Box
        .PARAMETER Credential
            PSCredential variable
        .PARAMETER AppId
            Identifier of the app instance the message filter belongs to
        .PARAMETER IPSecIdentifier
            IPSec identifier
        .PARAMETER IPSecPreSharedKey
            IPSec pre-shared-key
        .PARAMETER IPSecXauthCredential
            Username and password for xauth as PSCredential
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppVpnWithPfs -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppVpnWithPfs -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppVpnWithPfs -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppVpnWithPfs -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
    #>

    Param
    (
        [switch]$Insecure = $false,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$AppId,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$IPSecIdentifier,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$IPSecPreSharedKey,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$IPSecXauthCredential

    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
        $avmWebrequestBody.Action = "SetAppVPNwithPFS"
        $avmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewIPSecIdentifier>{1}</s:NewIPSecIdentifier>
<s:NewIPSecPreSharedKey>{2}</s:NewIPSecPreSharedKey>
<s:NewIPSecXauthUsername>{3}</s:NewIPSecXauthUsername>
<s:NewIPSecXauthPassword>{4}</s:NewIPSecXauthPassword>
"@ -f $AppId, $IPSecIdentifier, $IPSecPreSharedKey, $IPSecXauthCredential.GetNetworkCredential().UserName, $IPSecXauthCredential.GetNetworkCredential().Password

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
            UrlPath = "/upnp/control/x_appsetup"
            XmlResponse = "SetAppVPNwithPFSResponse"
        }

        Invoke-AvmAction @splatParameters
    }
}