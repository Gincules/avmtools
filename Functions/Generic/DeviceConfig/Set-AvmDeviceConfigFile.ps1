function Set-AvmDeviceConfigFile {
    <#
        .SYNOPSIS
            Set FRITZ!Box configuration file
        .DESCRIPTION
            Set FRITZ!Box configuration file
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
        .PARAMETER ConfigPassword
            Argument list of action SetConfig
        .PARAMETER ConfigFileUrl
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
            PS C:\> Set-AvmDeviceConfigFile -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmDeviceConfigFile -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmDeviceConfigFile -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmDeviceConfigFile -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
    #>

    Param
    (
        [switch]$Insecure = $false,
        [switch]$RemoteAccess = $false,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential,
        [ValidateNotNullOrEmpty()][PSCredential]$ConfigPassword,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$ConfigFileUrl
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:DeviceConfig:1"
        $avmWebrequestBody.Action = "X_AVM-DE_SetConfigFile"
        $avmWebrequestBody.InnerBody = @"
<s:NewX_AVM-DE_Password>{0}</s:NewX_AVM-DE_Password>
<s:NewX_AVM-DE_ConfigFileUrl>{1}</s:NewX_AVM-DE_ConfigFileUrl>
"@ -f $ConfigPassword.GetNetworkCredential().Password, $ConfigFileUrl

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
            UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
            XmlResponse = "X_AVM-DE_SetConfigFileResponse"
        }

        Invoke-AvmAction @splatParameters
    }
}