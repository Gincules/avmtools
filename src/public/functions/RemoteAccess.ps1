function Enable-AvmRemoteAccess {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmRemoteAccess
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmRemoteAccess
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
        [ValidateRange(0,4294967295)]
        [System.Byte][System.Boolean]$NewEnabled
    )

    $avmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_RemoteAccess:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_remote"
    $AvmWebrequestBody.Action = "SetEnable"
    $AvmWebrequestBody.InnerBody = "<s:NewEnabled>{0}</s:NewEnabled>" -f $NewEnabled

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        Body = $AvmWebrequestBody.GenerateBody()
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmRemoteAccessDdnsInfo {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmRemoteAccessDdnsInfo
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmRemoteAccessDdnsInfo
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_RemoteAccess:1#GetDDNSInfo"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_remote"
        XmlResponse = "GetDDNSInfoResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmRemoteAccessDdnsProvider {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmRemoteAccessDdnsProvider
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmRemoteAccessDdnsProvider
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_RemoteAccess:1#GetDDNSProviders"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_remote"
        XmlResponse = "GetDDNSProvidersResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmRemoteAccessInfo {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmRemoteAccessInfo
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmRemoteAccessInfo
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_RemoteAccess:1#GetInfo"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_remote"
        XmlResponse = "GetInfoResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Set-AvmRemoteAccessConfig {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmRemoteAccessConfig
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmRemoteAccessConfig
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
        [System.Byte][System.Boolean]$NewEnabled,

        [Parameter(Mandatory)]
        [ValidateRange(1,65535)]
        [System.UInt16]$NewPort,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewUsername,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewPassword
    )

    $SecurePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
    $PlainNewPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecurePointer)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($SecurePointer)

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_RemoteAccess:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_remote"
    $AvmWebrequestBody.Action = "SetConfig"
    $AvmWebrequestBody.InnerBody = @"
<s:NewEnabled>{0}</s:NewEnabled>
<s:NewPort>{1}</s:NewPort>
<s:NewUsername>{2}</s:NewUsername>
<s:NewPassword>{3}</s:NewPassword>
"@ -f $NewEnabled, $NewPort, $NewUsername, $PlainNewPassword

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        Body = $AvmWebrequestBody.GenerateBody()
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}

function Set-AvmRemoteAccessDdnsConfig {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmRemoteAccessDdnsConfig
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmRemoteAccessDdnsConfig
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
        [ValidateRange(0,4294967295)]
        [System.Byte][System.Boolean]$NewEnabled,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewProviderName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewUpdateURL,

        [Parameter()]
        [System.String]$NewServerIPv4,

        [Parameter()]
        [System.String]$NewServerIPv6,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewDomain,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewUsername,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewPassword,

        [Parameter(Mandatory)]
        [ValidateSet("ddns_v4","ddns_v6","ddns_both")]
        [System.String]$NewMode
    )

    $SecurePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
    $PlainNewPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecurePointer)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($SecurePointer)

    $avmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_RemoteAccess:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_remote"
    $AvmWebrequestBody.Action = "SetDDNSConfig"
    $AvmWebrequestBody.InnerBody = @"
<s:NewEnabled>{0}</s:NewEnabled>
<s:NewProviderName>{1}</s:NewProviderName>
<s:NewUpdateURL>{2}</s:NewUpdateURL>
<s:NewServerIPv4>{3}</s:NewServerIPv4>
<s:NewServerIPv6>{4}</s:NewServerIPv6>
<s:NewDomain>{5}</s:NewDomain>
<s:NewUsername>{6}</s:NewUsername>
<s:NewPassword>{7}</s:NewPassword>
<s:NewMode>{8}</s:NewMode>
"@ -f $NewEnabled, $NewProviderName, $NewUpdateURL, $NewServerIPv4, $NewServerIPv6, $NewDomain, $NewUsername, $PlainNewPassword, $NewMode

    [System.Collections.Hashtable]$SplatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = $AvmWebrequestBody.GenerateSoapAction()
        UrlPath = $AvmWebrequestBody.UrlPath
        Body = $AvmWebrequestBody.GenerateBody()
        XmlResponse = $AvmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @SplatParameters
}