function Switch-AvmHomeautoDevice {
    <#
        .SYNOPSIS
            Switch FRITZ!Box device status
        .DESCRIPTION
            Switch FRITZ!Box device status
        .PARAMETER RemoteAccess
            Access FRITZ!Box from the internet
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
        .PARAMETER a
            Argument list of action SetConfig
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Switch-AvmHomeautoDevice -RemoteAccess -Url "https://myfritzaddress12.myfritz.net" -Port 443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Switch-AvmHomeautoDevice -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Switch-AvmHomeautoDevice -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Switch-AvmHomeautoDevice -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Switch-AvmHomeautoDevice -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
    #>

    Param
    (
        [switch]$Insecure = $false,
        [switch]$RemoteAccess = $false,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Ain,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$NewSwitchState
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Homeauto:1"
        $avmWebrequestBody.Action = "SetDeviceName"
        $avmWebrequestBody.InnerBody = @"
<s:NewAIN>{0}</s:NewAIN>
<s:NewSwitchState>{1}</s:NewSwitchState>
"@-f $Ain, $NewSwitchState

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
            UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_homeauto"
            XmlResponse = "SetDeviceNameResponse"
        }

        Invoke-AvmAction @splatParameters
    }
}