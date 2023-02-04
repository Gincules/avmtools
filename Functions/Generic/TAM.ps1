function Enable-AvmTam {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmTam
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmTam
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Enable-AvmTam
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
        [System.Byte][System.Boolean]$NewIndex,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$NewEnable
    )

    Begin {
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_TAM:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_tam"
        $AvmWebrequestBody.Action = "SetEnable"
        $AvmWebrequestBody.InnerBody = @"
<s:NewIndex>{0}</s:NewIndex>
<s:NewEnable>{1}</s:NewEnable>
"@ -f $NewIndex, $NewEnable
    }

    Process {
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
}

function Get-AvmTamInfo {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmTamInfo
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmTamInfo
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmTamInfo
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
        [System.Byte][System.Boolean]$NewIndex,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$NewEnable
    )

    Begin {
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_TAM:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_tam"
        $AvmWebrequestBody.Action = "GetInfo"
        $AvmWebrequestBody.InnerBody = "<s:NewIndex>{0}</s:NewIndex>" -f $NewIndex
    }

    Process {
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
}

function Get-AvmTamList {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmTamList
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmTamList
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmTamList
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_TAM:1#GetList"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_tam"
        XmlResponse = "GetListResponse"
    }
    
    Connect-AvmDevice @SplatParameters
}

function Get-AvmTamMessageList {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmTamMessageList
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmTamMessageList
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmTamMessageList
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

    Begin {
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_TAM:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_tam"
        $AvmWebrequestBody.Action = "GetMessageList"
        $AvmWebrequestBody.InnerBody = "<s:NewIndex>{0}</s:NewIndex>" -f $NewIndex
    }

    Process {
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
}

function Remove-AvmTamMessage {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmTamMessage
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmTamMessage
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmTamMessage
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
        [ValidateRange(0,65535)]
        [System.UInt16]$NewMessageIndex
    )

    Begin {
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_TAM:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_tam"
        $AvmWebrequestBody.Action = "DeleteMessage"
        $AvmWebrequestBody.InnerBody = @"
<s:NewIndex>{0}</s:NewIndex>
<s:NewMessageIndex>{1}</s:NewMessageIndex>
"@ -f $NewIndex, $NewMessageIndex
    }

    Process {
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
}

function Set-AvmTamMarkMessage {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmTamMarkMessage
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmTamMarkMessage
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmTamMarkMessage
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
        [ValidateRange(0,65535)]
        [System.UInt16]$NewMessageIndex,

        [System.Byte][System.Boolean]$NewMarkedAsRead
    )

    Begin {
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_TAM:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_tam"
        $AvmWebrequestBody.Action = "MarkMessage"
        $AvmWebrequestBody.InnerBody = @"
<s:NewIndex>{0}</s:NewIndex>
<s:NewMessageIndex>{1}</s:NewMessageIndex>
<s:NewMarkedAsRead>{2}</s:NewMarkedAsRead>
"@ -f $NewIndex, $NewMessageIndex, $NewMarkedAsRead
    }

    Process {
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
}