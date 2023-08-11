function Enable-AvmOnTel {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmOnTel
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmOnTel
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
        [System.UInt32]$NewIndex
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "SetEnable"
    $AvmWebrequestBody.InnerBody = "<s:NewIndex>{0}</s:NewIndex>" -f $NewIndex

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

function Enable-AvmOnTelByIndex {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmOnTelByIndex
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmOnTelByIndex
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

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(0,65535)]
        [System.UInt16]$NewIndex,

        [Parameter()]
        [System.Byte][System.Boolean]$NewEnable
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "SetEnableByIndex"
    $AvmWebrequestBody.InnerBody = @"
<s:NewIndex>{0}</s:NewIndex>
<s:NewEnable>{1}</s:NewEnable>
"@ -f $NewIndex, $NewEnable

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

function Enable-AvmOnTelConfigByIndex {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmOnTelConfigByIndex
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmOnTelConfigByIndex
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
        [System.UInt16]$NewIndex,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Byte][System.Boolean]$NewEnable,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewUrl,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewServiceId,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewUsername,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewPassword,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewName
    )

    $SecurePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
    $PlainNewPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecurePointer)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($SecurePointer)

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "SetConfigByIndex"
    $AvmWebrequestBody.InnerBody = @"
<s:NewIndex>{0}</s:NewIndex>
<s:NewEnable>{1}</s:NewEnable>
<s:NewUrl>{2}</s:NewUrl>
<s:NewServiceId>{3}</s:NewServiceId>
<s:NewUsername>{4}</s:NewUsername>
<s:NewPassword>{5}</s:NewPassword>
<s:NewName>{6}</s:NewName>
"@ -f $NewIndex, $NewEnable, $NewUrl, $NewServiceId, $NewUsername, $PlainNewPassword, $NewName

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

function Enable-AvmOnTelDeflection {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmOnTelDeflection
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmOnTelDeflection
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

        [Parameter()]
        [System.String]$NewDeflectionId,

        [Parameter()]
        [System.Byte][System.Boolean]$NewEnable
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "SetDeflectionEnable"
    $AvmWebrequestBody.InnerBody = @"
<s:NewDeflectionId>{0}</s:NewDeflectionId>
<s:NewEnable>{1}</s:NewEnable>
"@ -f $NewDeflectionId, $NewEnable

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

function Get-AvmOnCallBarringEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnCallBarringEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnCallBarringEntry
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

        [Parameter()]
        [System.UInt32]$NewPhonebookEntryID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "GetCallBarringEntry"
    $AvmWebrequestBody.InnerBody = "<s:NewPhonebookEntryID>{0}</s:NewPhonebookEntryID>" -f $NewPhonebookEntryID

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

function Get-AvmOnTelBarringEntryByNum {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelBarringEntryByNum
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelBarringEntryByNum
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

        [Parameter()]
        [System.String]$NewNumber
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "GetCallBarringEntryByNum"
    $AvmWebrequestBody.InnerBody = "<s:NewNumber>{0}</s:NewNumber>" -f $NewNumber

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

function Get-AvmOnTelCallBarringList {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelCallBarringList
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelCallBarringList
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1#GetCallBarringList"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        XmlResponse = "GetCallBarringListResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmOnTelCallList {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelCallList
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelCallList
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1#GetCallList"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        XmlResponse = "GetCallListResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmOnTelDectHandsetInfo {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelDectHandsetInfo
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelDectHandsetInfo
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

        [ValidateRange(0,65535)]
        [ValidateNotNullOrEmpty()]
        [System.UInt16]$NewDectID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "GetDECTHandsetInfo"
    $AvmWebrequestBody.InnerBody = "<s:NewDectID>{0}</s:NewDectID>" -f $NewDectID

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

function Get-AvmOnTelDectHandsetList {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelDectHandsetList
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelDectHandsetList
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1#GetDECTHandsetList"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        XmlResponse = "GetDECTHandsetListResponse"
    }
    
    Connect-AvmDevice @SplatParameters
}

function Get-AvmOnTelDeflection {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelDeflection
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelDeflection
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1#GetDeflections"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        XmlResponse = "GetDeflectionsResponse"
    }
    
    Connect-AvmDevice @SplatParameters
}

function Get-AvmOnTelDeflectionById {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelDeflectionById
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelDeflectionById
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
        [ValidateRange(0,65535)]
        [System.UInt16]$NewDeflectionId
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "GetDeflection"
    $AvmWebrequestBody.InnerBody = "<s:NewDeflectionId>{0}</s:NewDeflectionId>" -f $NewDeflectionId

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

function Get-AvmOnTelInfo {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelInfo
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelInfo
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1#GetInfo"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        XmlResponse = "GetInfoResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmOnTelInfoByIndex {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelInfoByIndex
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelInfoByIndex
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
        [ValidateRange(0,65535)]
        [System.UInt16]$NewIndex
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "GetInfoByIndex"
    $AvmWebrequestBody.InnerBody = "<s:NewIndex>{0}</s:NewIndex>" -f $NewIndex

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

function Get-AvmOnTelNumberOfDeflection {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelNumberOfDeflection
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelNumberOfDeflection
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1#GetNumberOfDeflections"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        XmlResponse = "GetNumberOfDeflectionsResponse"
    }
    
    Connect-AvmDevice @SplatParameters
}

function Get-AvmOnTelNumberOfEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelNumberOfEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelNumberOfEntry
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1#GetNumberOfEntries"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        XmlResponse = "GetNumberOfEntriesResponse"
    }
    
    Connect-AvmDevice @SplatParameters
}

function Get-AvmOnTelPhonebookEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelPhonebookEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelPhonebookEntry
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

        [Parameter()]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookID,

        [Parameter()]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookEntryID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "GetPhonebookEntry"
    $AvmWebrequestBody.InnerBody = @"
<s:NewPhonebookID>{0}</s:NewPhonebookID>
<s:NewPhonebookExtraID>{1}</s:NewPhonebookExtraID>
"@ -f $NewPhonebookID, $NewPhonebookExtraID

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

function Get-AvmOnTelPhonebookEntryUid {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelPhonebookEntryUid
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelPhonebookEntryUid
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

        [Parameter()]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookID,

        [Parameter()]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookEntryUniqueID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "GetPhonebookEntryUID"
    $AvmWebrequestBody.InnerBody = @"
<s:NewPhonebookID>{0}</s:NewPhonebookID>
<s:NewPhonebookEntryUniqueID>{1}</s:NewPhonebookEntryUniqueID>
"@ -f $NewPhonebookID, $NewPhonebookEntryUniqueID

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

function Get-AvmOnTelPhonebookList {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelPhonebookList
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelPhonebookList
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1#GetPhonebookList"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        XmlResponse = "GetPhonebookListResponse"
    }
    
    Connect-AvmDevice @SplatParameters
}

function Get-AvmOnTelPhonelist {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelPhonelist
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmOnTelPhonelist
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

        [Parameter()]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "GetPhonebook"
    $AvmWebrequestBody.InnerBody = "<s:NewPhonebookID>{0}</s:NewPhonebookID>" -f $NewPhonebookID

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

function New-AvmOnTelPhonebook {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/New-AvmOnTelPhonebook
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/New-AvmOnTelPhonebook
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
        [ValidateRange(0,65535)]
        [System.UInt16]$NewIndex,

        [Parameter()]
        [System.Byte][System.Boolean]$NewEnable
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "AddPhonebook"
    $AvmWebrequestBody.InnerBody = @"
<s:NewIndex>{0}</s:NewIndex>
<s:NewEnable>{1}</s:NewEnable>
"@ -f $NewIndex, $NewEnable

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

function Remove-AvmOnTelByIndex {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelByIndex
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelByIndex
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
        [ValidateRange(0,65535)]
        [System.UInt16]$NewIndex
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "DeleteByIndex"
    $AvmWebrequestBody.InnerBody = "<s:NewIndex>{0}</s:NewIndex>" -f $NewIndex

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

function Remove-AvmOnTelCallBarringEntryUid {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelCallBarringEntryUid
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelCallBarringEntryUid
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
        [System.UInt32]$NewPhonebookEntryUniqueID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "DeleteCallBarringEntryUID"
    $AvmWebrequestBody.InnerBody = "<s:NewPhonebookEntryUniqueID>{0}</s:NewPhonebookEntryUniqueID>" -f $NewPhonebookEntryUniqueID

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

function Remove-AvmOnTelPhonebook {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelPhonebook
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelPhonebook
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
        [System.UInt32]$NewPhonebookID,

        [Parameter(Mandatory)]
        [System.String]$NewPhonebookExtraID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "DeletePhonebook"
    $AvmWebrequestBody.InnerBody = @"
<s:NewPhonebookID>{0}</s:NewPhonebookID>
<s:NewPhonebookExtraID>{1}</s:NewPhonebookExtraID>
"@ -f $NewPhonebookID, $NewPhonebookExtraID

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

function Remove-AvmOnTelPhonebookEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelPhonebookEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelPhonebookEntry
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
        [System.UInt32]$NewPhonebookID,

        [Parameter(Mandatory)]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookEntryID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "DeletePhonebookEntry"
    $AvmWebrequestBody.InnerBody = @"
<s:NewPhonebookID>{0}</s:NewPhonebookID>
<s:NewPhonebookEntryID>{1}</s:NewPhonebookEntryID>
"@ -f $NewPhonebookID, $NewPhonebookEntryID

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

function Remove-AvmOnTelPhoneEntryByUid {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelPhoneEntryByUid
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelPhoneEntryByUid
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

        [Parameter()]
        [string]$NewPhonebookID,

        [Parameter()]
        [string]$NewPhonebookEntryUniqueID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "DeletePhonebookEntryUID"
    $AvmWebrequestBody.InnerBody = @"
<s:NewPhonebookID>{0}</s:NewPhonebookID>
<s:NewPhonebookEntryUniqueID>{1}</s:NewPhonebookEntryUniqueID>
"@ -f $NewPhonebookID, $NewPhonebookEntryUniqueID

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

function Set-AvmOnTelCallBarringEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelCallBarringEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelCallBarringEntry
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

        [Parameter()]
        [System.String]$NewPhonebookEntryData
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "SetCallBarringEntry"
    $AvmWebrequestBody.InnerBody = "<s:NewPhonebookEntryData>{0}</s:NewPhonebookEntryData>" -f $NewPhonebookEntryData

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

function Set-AvmOnTelConfig {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelConfig
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelConfig
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
        [ValidateRange(0,65535)]
        [System.UInt16]$NewIndex,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewUrl,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewServiceId,

        [Parameter()]
        [System.Management.Automation.PSCredential]$NewCredential,

        [Parameter()]
        [System.String]$NewName
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "SetConfig"
    $AvmWebrequestBody.InnerBody = @"
<s:NewIndex>{0}</s:NewIndex>
<s:NewUrl>{1}</s:NewUrl>
<s:NewServiceId>{2}</s:NewServiceId>
<s:NewUsername>{3}</s:NewUsername>
<s:NewPassword>{4}</s:NewPassword>
<s:NewName>{5}</s:NewName>
"@ -f $NewIndex, $NewUrl, $NewServiceId, $NewCredential.GetNetworkCredential().UserName, $NewCredential.GetNetworkCredential().Password, $NewName

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

function Set-AvmOnTelDectHandsetPhonebook {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelDectHandsetPhonebook
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelDectHandsetPhonebook
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
        [System.String]$NewDectID,

        [Parameter(Mandatory)]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookID
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "SetDECTHandsetPhonebook"
    $AvmWebrequestBody.InnerBody = @"
<s:NewDectID>{0}</s:NewDectID>
<s:NewPhonebookID>{0}</s:NewPhonebookID>
"@ -f $NewDectID, $NewPhonebookID

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

function Set-AvmOnTelPhonebookEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelPhonebookEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelPhonebookEntry
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

        [Parameter()]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookID,

        [Parameter()]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookEntryID,

        [Parameter()]
        [System.String]$NewPhonebookEntryData
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "SetPhonebookEntry"
    $AvmWebrequestBody.InnerBody = @"
<s:NewPhonebookID>{0}</s:NewPhonebookID>
<s:NewPhonebookEntryID>{1}</s:NewPhonebookEntryID>
<s:NewPhonebookEntryData>{2}</s:NewPhonebookEntryData>
"@ -f $NewPhonebookID, $NewPhonebookExtraID, $NewPhonebookEntryData

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

function Set-AvmOnTelPhonebookEntryUid {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelPhonebookEntryUid
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelPhonebookEntryUid
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
        [System.UInt32]$NewPhonebookID,

        [Parameter()]
        [System.String]$NewPhonebookEntryData
    )

    $AvmWebrequestBody = [AvmBody]::new()
    $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
    $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
    $AvmWebrequestBody.Action = "SetPhonebookEntryUID"
    $AvmWebrequestBody.InnerBody = @"
<s:NewPhonebookID>{0}</s:NewPhonebookID>
<s:NewPhonebookEntryData>{1}</s:NewPhonebookEntryData>
"@ -f $NewPhonebookID, $NewPhonebookEntryData

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