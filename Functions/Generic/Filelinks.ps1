function Get-AvmFilelinkListPath {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmFilelinkListPath
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmFilelinkListPath
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

    [System.Collections.Hashtable]$splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_Filelinks:1#GetFilelinkListPath"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_filelinks"
        XmlResponse = "GetFilelinkListPathResponse"
    }

    Connect-AvmDevice @splatParameters
}

function Get-AvmFilelinkNumberOfEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmFilelinkNumberOfEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmFilelinkNumberOfEntry
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

    [System.Collections.Hashtable]$splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_Filelinks:1#GetNumberOfFilelinkEntries"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_filelinks"
        XmlResponse = "GetNumberOfFilelinkEntriesResponse"
    }

    Connect-AvmDevice @splatParameters
}

function Get-AvmGenericFilelinkEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmGenericFilelinkEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmGenericFilelinkEntry
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

    $avmWebrequestBody = [AvmBody]::new()
    $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Filelinks:1"
    $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_filelinks"
    $avmWebrequestBody.Action = "GetGenericFilelinkEntry"
    $avmWebrequestBody.InnerBody = "<s:NewIndex>{0}</s:NewIndex>" -f $NewIndex

    [System.Collections.Hashtable]$splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $avmWebrequestBody.GenerateBody()
        SoapAction = $avmWebrequestBody.GenerateSoapAction()
        UrlPath = $avmWebrequestBody.UrlPath
        XmlResponse = $avmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @splatParameters
}

function Get-AvmSpecificFilelinkEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmSpecificFilelinkEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmSpecificFilelinkEntry
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
        [System.String]$NewID
    )

    $avmWebrequestBody = [AvmBody]::new()
    $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Filelinks:1"
    $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_filelinks"
    $avmWebrequestBody.Action = "GetSpecificFilelinkEntry"
    $avmWebrequestBody.InnerBody = "<s:NewID>{0}</s:NewID>" -f $NewID

    [System.Collections.Hashtable]$splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $avmWebrequestBody.GenerateBody()
        SoapAction = $avmWebrequestBody.GenerateSoapAction()
        UrlPath = $avmWebrequestBody.UrlPath
        XmlResponse = $avmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @splatParameters
}

function New-AvmFilelinkEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/New-AvmFilelinkEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/New-AvmFilelinkEntry
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

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewPath,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$NewAccessCountLimit,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$NewExpire
    )

    $avmWebrequestBody = [AvmBody]::new()
    $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Filelinks:1"
    $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_filelinks"
    $avmWebrequestBody.Action = "NewFilelinkEntry"
    $avmWebrequestBody.InnerBody = @"
<s:NewPath>{0}</s:NewPath>
<s:NewAccessCountLimit>{1}</s:NewAccessCountLimit>
<s:NewExpire>{2}</s:NewExpire>
"@ -f $NewPath, $NewAccessCountLimit, $NewExpire

    [System.Collections.Hashtable]$splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $avmWebrequestBody.GenerateBody()
        SoapAction = $avmWebrequestBody.GenerateSoapAction()
        UrlPath = $avmWebrequestBody.UrlPath
        XmlResponse = $avmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @splatParameters
}

function Remove-AvmFilelinkEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmFilelinkEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmFilelinkEntry
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
        [System.String]$NewID
    )

    $avmWebrequestBody = [AvmBody]::new()
    $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Filelinks:1"
    $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_filelinks"
    $avmWebrequestBody.Action = "DeleteFilelinkEntry"
    $avmWebrequestBody.InnerBody = "<s:NewID>{0}</s:NewID>"-f $NewID
 
    [System.Collections.Hashtable]$splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $avmWebrequestBody.GenerateBody()
        SoapAction = $avmWebrequestBody.GenerateSoapAction()
        UrlPath = $avmWebrequestBody.UrlPath
        XmlResponse = $avmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @splatParameters
}

function Set-AvmFilelinkEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmFilelinkEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmFilelinkEntry
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
        [System.String]$NewID,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$NewAccessCountLimit,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.UInt16]$NewExpire
    )

    $avmWebrequestBody = [AvmBody]::new()
    $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Filelinks:1"
    $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_filelinks"
    $avmWebrequestBody.Action = "SetFilelinkEntry"
    $avmWebrequestBody.InnerBody = @"
<s:NewID>{0}</s:NewID>
<s:NewAccessCountLimit>{1}</s:NewAccessCountLimit>
<s:NewExpire>{2}</s:NewExpire>
"@ -f $NewID, $NewAccessCountLimit, $NewExpire

    [System.Collections.Hashtable]$splatParameters = @{
        Insecure = $Insecure
        Url = $Url
        Port = $Port
        Credential = $Credential
        Body = $avmWebrequestBody.GenerateBody()
        SoapAction = $avmWebrequestBody.GenerateSoapAction()
        UrlPath = $avmWebrequestBody.UrlPath
        XmlResponse = $avmWebrequestBody.GenerateXmlResponse()
    }

    Connect-AvmDevice @splatParameters
}