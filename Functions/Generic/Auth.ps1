function Get-AvmAuthInfo {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAuthInfo
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAuthInfo
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAuthInfo
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_Auth:1#GetInfo"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_auth"
        XmlResponse = "GetInfoResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmAuthState {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAuthState
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAuthState
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmAuthState
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
        SoapAction = "urn:dslforum-org:service:X_AVM-DE_Auth:1#GetState"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_auth"
        XmlResponse = "GetStateResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Set-AvmAuthConfig {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAuthConfig
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAuthConfig
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAuthConfig
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
        [ValidateSet("start","stop")]
        [System.String]$NewAction
    )

    Begin {
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Auth:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_auth"
        $AvmWebrequestBody.Action = "SetConfig"
        $AvmWebrequestBody.InnerBody = "<s:NewAction>{0}</s:NewAction>" -f $NewAction
    }

    Process {
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
}