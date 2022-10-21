function Set-AvmAppMessageReceiver {
    <#
        .SYNOPSIS
            Set FRITZ!Box app message filter
        .DESCRIPTION
            Set FRITZ!Box app message filter
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
        .PARAMETER CryptAlgos
            Comma separated list of additional crypt algorithms the
            app understands beside AES128-CBC-HMAC-SHA-256.
            If no other crypt algorithms are supported this parameter
            can be left blank. Naming according to RFC7518 (JWA).
        .PARAMETER AppAVMAddress
            "App-AVM-Address" of the app Instance. An empty
            string means that the app instance will no longer receive
            any messages from this box (message receiver delete
            operation). The app gets this value from the AVM
            message relay web service.
        .PARAMETER AppAVMHash
            BASE64URL encoding (without padding) of first 16
            Bytes of the SHA-256 hash of the app's "App-AVMPassword". The app gets this value from the AVM
            message relay web service.
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppMessageReceiver -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppMessageReceiver -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppMessageReceiver -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Set-AvmAppMessageReceiver -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
    #>

    Param
    (
        [switch]$Insecure = $false,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$AppId,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$CryptAlgos,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$AppAvmAddress,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$AppAvmHash
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
        $avmWebrequestBody.Action = "SetAppMessageReceiver"
        $avmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewCryptAlgos>{1}</s:NewCryptAlgos>
<s:NewAppAVMAddress>{2}</s:NewAppAVMAddress>
<s:NewAppAVMPasswordHash>{3}</s:NewAppAVMPasswordHash>
"@ -f $AppId, $CryptAlgos, $AppAvmAddress, $AppAvmHash

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
            XmlResponse = "SetAppMessageReceiverResponse"
        }

        Invoke-AvmAction @splatParameters
    }
}