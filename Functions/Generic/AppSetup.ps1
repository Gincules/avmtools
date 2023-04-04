function Get-AvmAppConfig {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAppConfig
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAppConfig
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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
        [System.Management.Automation.PSCredential]$Credential
    )

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1#GetConfig"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_appsetup"
        XmlResponse = "GetConfigResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmAppInfo {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAppInfo
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAppInfo
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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
        [System.Management.Automation.PSCredential]$Credential
    )

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1#GetInfo"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_appsetup"
        XmlResponse = "GetInfoResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmAppMessageFilter {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAppMessageFilter
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAppMessageFilter
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppId
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_appsetup"
    $AvmWebrequestBody.Action = "GetAppMessageFilter"
    $AvmWebrequestBody.InnerBody = "<s:NewAppId>{0}</s:NewAppId>" -f $NewAppId

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $AvmWebrequestBody.GenerateBody()
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmAppRemoteInfo {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAppRemoteInfo
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAppRemoteInfo
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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
        [System.Management.Automation.PSCredential]$Credential
    )

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1#GetAppRemoteInfo"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_appsetup"
        XmlResponse = "GetAppRemoteInfoResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Register-AvmApp {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Register-AvmApp
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Register-AvmApp
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppId,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppDisplayName,

        [Parameter()]
        [System.String]$NewAppDeviceMAC,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppUsername,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewAppPassword,

        [Parameter(Mandatory)]
        [ValidateSet("NO","RO","RW","UNDEFINED")]
        [RightEnum]$NewAppRight,

        [Parameter(Mandatory)]
        [ValidateSet("NO","RO","RW","UNDEFINED")]
        [RightEnum]$NewNasRight,

        [Parameter(Mandatory)]
        [ValidateSet("NO","RO","RW","UNDEFINED")]
        [RightEnum]$NewPhoneRight,

        [Parameter(Mandatory)]
        [ValidateSet("NO","RO","RW","UNDEFINED")]
        [RightEnum]$NewHomeautoRight,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.SByte][System.Boolean]$NewAppInternetRights
    )

    $SecurePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewAppPassword)
    $PlainNewAppPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecurePointer)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($SecurePointer)

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
    $AvmWebrequestBody.UrlPath = "/upnp/control/x_appsetup"
    $AvmWebrequestBody.Action = "RegisterApp"
    $AvmWebrequestBody.InnerBody = @"
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
"@ -f $NewAppId, $NewAppDisplayName, $NewAppDeviceMAC, $NewAppUsername, $PlainNewAppPassword, $NewAppRight, $NewNasRight, $NewPhoneRight, $NewHomeautoRight, $NewAppInternetRights

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $AvmWebrequestBody.GenerateBody()
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}

function Reset-AvmEvent {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Reset-AvmEvent
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Reset-AvmEvent
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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

        [Parameter(Mandatory)]
        [ValidateSet(0,300,500,501,502)]
        [System.Uint32]$NewEventId
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
    $AvmWebrequestBody.UrlPath = "/upnp/control/x_appsetup"
    $AvmWebrequestBody.Action = "ResetEvent"
    $AvmWebrequestBody.InnerBody = "<s:NewEventId>{0}</s:NewEventId>" -f $NewEventId

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $AvmWebrequestBody.GenerateBody()
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}

function Set-AvmAppMessageFilter {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppMessageFilter
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppMessageFilter
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppId,

        [Parameter(Mandatory)]
        [ValidateSet("aha_ident","tel_local_number")]
        [System.String]$NewType,

        [Parameter(Mandatory)]
        [ValidateLength(1,1024)]
        [System.String]$NewFilter
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_appsetup"
    $AvmWebrequestBody.Action = "SetAppMessageFilter"
    $AvmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewType>{1}</s:NewType>
<s:NewEventId>{2}</s:NewEventId>
"@ -f $NewAppId, $NewType, $NewFilter

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $AvmWebrequestBody.GenerateBody()
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}

function Set-AvmAppMessageReceiver {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppMessageReceiver
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppMessageReceiver
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppId,

        [Parameter()]
        [System.String]$NewCryptAlgos,

        [Parameter()]
        [System.String]$NewAppAVMAddress,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewAppAVMPasswordHash
    )

    $SecurePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewAppAVMPasswordHash)
    $PlainNewAppAVMPasswordHash = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecurePointer)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($SecurePointer)

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
    $AvmWebrequestBody.UrlPath = "/upnp/control/x_appsetup"
    $AvmWebrequestBody.Action = "SetAppMessageReceiver"
    $AvmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewCryptAlgos>{1}</s:NewCryptAlgos>
<s:NewAppAVMAddress>{2}</s:NewAppAVMAddress>
<s:NewAppAVMPasswordHash>{3}</s:NewAppAVMPasswordHash>
"@ -f $NewAppId, $NewCryptAlgos, $NewAppAVMAddress, $PlainNewAppAVMPasswordHash

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $AvmWebrequestBody.GenerateBody()
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}

function Set-AvmAppVpn {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppVpn
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppVpn
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppId,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewIPSecIdentifier,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewIPSecPreSharedKey,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewIPSecXauthUsername,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewIPSecXauthPassword
    )

    $SecurePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewIPSecXauthPassword)
    $PlainNewIPSecXauthPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecurePointer)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($SecurePointer)

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
    $AvmWebrequestBody.UrlPath = "/upnp/control/x_appsetup"
    $AvmWebrequestBody.Action = "SetAppVPN"
    $AvmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewIPSecIdentifier>{1}</s:NewIPSecIdentifier>
<s:NewIPSecPreSharedKey>{2}</s:NewIPSecPreSharedKey>
<s:NewIPSecXauthUsername>{3}</s:NewIPSecXauthUsername>
<s:NewIPSecXauthPassword>{4}</s:NewIPSecXauthPassword>
"@ -f $NewAppId, $NewIPSecIdentifier, $NewIPSecPreSharedKey, $NewIPSecXauthUsername, $PlainNewIPSecXauthPassword

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $AvmWebrequestBody.GenerateBody()
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}

function Set-AvmAppVpnWithPfs {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppVpnWithPfs
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppVpnWithPfs
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
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
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppId,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewIPSecIdentifier,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewIPSecPreSharedKey,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewIPSecXauthUsername,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewIPSecXauthPassword
    )

    $SecurePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewIPSecXauthPassword)
    $PlainNewIPSecXauthPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecurePointer)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($SecurePointer)

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
    $AvmWebrequestBody.UrlPath = "/upnp/control/x_appsetup"
    $AvmWebrequestBody.Action = "SetAppVPNwithPFS"
    $AvmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewIPSecIdentifier>{1}</s:NewIPSecIdentifier>
<s:NewIPSecPreSharedKey>{2}</s:NewIPSecPreSharedKey>
<s:NewIPSecXauthUsername>{3}</s:NewIPSecXauthUsername>
<s:NewIPSecXauthPassword>{4}</s:NewIPSecXauthPassword>
"@ -f $NewAppId, $NewIPSecIdentifier, $NewIPSecPreSharedKey, $NewIPSecXauthUsername, $PlainNewIPSecXauthPassword

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $AvmWebrequestBody.GenerateBody()
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}