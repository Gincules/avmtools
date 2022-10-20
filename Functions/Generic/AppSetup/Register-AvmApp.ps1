function Register-AvmApp {
    <#
        .SYNOPSIS
            Get FRITZ!Box app meesage filter by id
        .DESCRIPTION
            Returns FRITZ!Box app meesage filter by id
        .PARAMETER Insecure
            Use unencrypted authentication over http instead of https
        .PARAMETER Url
            Url of FRITZ!Box
        .PARAMETER Port
            Port of FRITZ!Box
        .PARAMETER Credential
            PSCredential variable
        .PARAMETER AppId
            Identifier of the app instance
        .PARAMETER AppDisplayName
            displayname of app
        .PARAMETER AppDeviceMAC
            MAC-Address of app
        .PARAMETER AppCredential
            PSCredential of app id user
        .PARAMETER AppRight
            Right of app. valid values are NO, RO or RW
        .PARAMETER NasRight
            NAS rights of app. valid values are NO, RO or RW
        .PARAMETER PhoneRight
            VOICE rights of app. valid values are NO, RO or RW
        .PARAMETER HomeautoRight
            HOMEAUTO rights of app. valid values are NO, RO or RW
        .PARAMETER AppInternetRights
            Internet Rights of app. valid values are true or false
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Register-AvmApp -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Register-AvmApp -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Register-AvmApp -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Register-AvmApp -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
    #>

    Param
    (
        [switch]$Insecure = $false,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$AppId,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$AppDisplayName,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$AppDeviceMAC,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$AppCredential,
        [Parameter(Mandatory=$true)][ValidateSet("NO","RO","RW","UNDEFINED")][string]$AppRight,
        [Parameter(Mandatory=$true)][ValidateSet("NO","RO","RW","UNDEFINED")][string]$NasRight,
        [Parameter(Mandatory=$true)][ValidateSet("NO","RO","RW","UNDEFINED")][string]$PhoneRight,
        [Parameter(Mandatory=$true)][ValidateSet("NO","RO","RW","UNDEFINED")][string]$HomeautoRight,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int][boolean]$AppInternetRights
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
        $avmWebrequestBody.Action = "RegisterApp"
        $avmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewAppDisplayName>{1}</s:NewAppDisplayName>
<s:NewAppDeviceMAC>{2}</s:NewAppDeviceMAC>
<s:NewAppUsername>{3}</s:NewAppUsername>
<s:NewAppPassword>{4}</s:NewAppPassword>
<s:NewAppRight>{5}</s:NewAppRight>
<s:NewNasRight>{6}</s:NewNasRight>
<s:NewPhoneRight>{7}</s:NewPhoneRight>
<s:NewHomeautoRight>{8}</s:NewHomeautoRight>
<s:NewAppInternetRights>{9}</s:NewAppInternetRights>
"@ -f $AppId, $AppDisplayName, $AppDeviceMAC, $AppCredential.GetNetworkCredential().UserName, $AppCredential.GetNetworkCredential().Password, $AppRight, $NasRight, $PhoneRight, $HomeautoRight, $AppInternetRights

        [xml]$avmBodyParameter = $avmWebrequestBody.GenerateBody()
        [string]$SoapAction = $avmWebrequestBody.GenerateSoapAction()
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            Body = $avmBodyParameter
            SoapAction = $SoapAction
            UrlPath = "/upnp/control/x_appsetup"
            XmlResponse = "RegisterAppResponse"
        }

        Invoke-AvmAction @splatParameters
    }
}