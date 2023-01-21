function Get-AvmDeviceConfigFile {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceConfigFile
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceConfigFile
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceConfigFile
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
        [System.Security.SecureString]
        $NewPassword = $null
    )

    Begin {
        if ($null -ne $NewPassword) {
            $SecurePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
            $PlainNewPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecurePointer)
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($SecurePointer)
        }

        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:DeviceConfig:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        $AvmWebrequestBody.Action = "X_AVM-DE_GetConfigFile"
        $AvmWebrequestBody.InnerBody = "<s:NewX_AVM-DE_Password>{0}</s:NewX_AVM-DE_Password>" -f $PlainNewPassword
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

function Get-AvmDeviceConfigurationFinished {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceConfigurationFinished
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceConfigurationFinished
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceConfigurationFinished
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
        SoapAction = "urn:dslforum-org:service:DeviceConfig:1#ConfigurationFinished"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        XmlResponse = "ConfigurationFinishedResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmDevicePersistentData {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDevicePersistentData
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDevicePersistentData
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDevicePersistentData
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
        SoapAction = "urn:dslforum-org:service:DeviceConfig:1#GetPersistentData"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        XmlResponse = "GetPersistentDataResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmDeviceSupportDataInfo {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceSupportDataInfo
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceSupportDataInfo
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceSupportDataInfo
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
        SoapAction = "urn:dslforum-org:service:DeviceConfig:1#X_AVM-DE_GetSupportDataInfo"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        XmlResponse = "X_AVM-DE_GetSupportDataInfoResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Get-AvmDeviceUuid {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceUuid
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceUuid
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Get-AvmDeviceUuid
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
        SoapAction = "urn:dslforum-org:service:DeviceConfig:1#X_GenerateUUID"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        XmlResponse = "X_GenerateUUIDResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function New-AvmDeviceUrlSid {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/New-AvmDeviceUrlSid
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/New-AvmDeviceUrlSid
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/New-AvmDeviceUrlSid
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
        SoapAction = "urn:dslforum-org:service:DeviceConfig:1#X_AVM-DE_CreateUrlSID"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        XmlResponse = "X_AVM-DE_CreateUrlSIDResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Reset-AvmDevice {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Reset-AvmDevice
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Reset-AvmDevice
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Reset-AvmDevice
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
        SoapAction = "urn:dslforum-org:service:DeviceConfig:1#FactoryReset"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        XmlResponse = "FactoryResetResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Restart-AvmDevice {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Restart-AvmDevice
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Restart-AvmDevice
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Restart-AvmDevice
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
        SoapAction = "urn:dslforum-org:service:DeviceConfig:1#Reboot"
        UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        XmlResponse = "RebootResponse"
    }

    Connect-AvmDevice @SplatParameters
}

function Send-AvmDeviceSupportData {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Send-AvmDeviceSupportData
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Send-AvmDeviceSupportData
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Send-AvmDeviceSupportData
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
        [ValidateSet("normal","mesh","unknown")]
        [System.String]$NewSupportDataMode
    )

    Begin {
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:DeviceConfig:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        $AvmWebrequestBody.Action = "X_AVM-DE_SendSupportData"
        $AvmWebrequestBody.InnerBody = "<s:NewX_AVM-DE_SupportDataMode>{0}</s:NewX_AVM-DE_SupportDataMode>" -f $NewSupportDataMode
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

function Set-AvmDeviceConfigFile {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmDeviceConfigFile
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmDeviceConfigFile
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmDeviceConfigFile
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
        [System.Security.SecureString]$NewPassword = $null,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewConfigFileUrl
    )

    Begin {
        if ($null -ne $NewPassword) {
            $SecurePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
            $PlainNewPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($SecurePointer)
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($SecurePointer)
        }
        
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:DeviceConfig:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        $AvmWebrequestBody.Action = "X_AVM-DE_SetConfigFile"
        $AvmWebrequestBody.InnerBody = @"
<s:NewX_AVM-DE_Password>{0}</s:NewX_AVM-DE_Password>
<s:NewX_AVM-DE_ConfigFileUrl>{1}</s:NewX_AVM-DE_ConfigFileUrl>
"@ -f $PlainNewPassword, $NewConfigFileUrl
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

function Set-AvmDevicePersistentData {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmDevicePersistentData
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmDevicePersistentData
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmDevicePersistentData
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
        [System.String]$NewPersistentData
    )

    Begin {
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:DeviceConfig:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        $AvmWebrequestBody.Action = "SetPersistentData"
        $AvmWebrequestBody.InnerBody = "<s:NewPersistentData>{0}</s:NewPersistentData>" -f $NewPersistentData
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

function Start-AvmDeviceConfiguration {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Start-AvmDeviceConfiguration
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Start-AvmDeviceConfiguration
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Start-AvmDeviceConfiguration
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
        [System.String]$NewSessionID
    )

    Begin {
        $AvmWebrequestBody = [AvmBody]::new()

        $AvmWebrequestBody.SoapAction = "urn:dslforum-org:service:DeviceConfig:1"
        $AvmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        $AvmWebrequestBody.Action = "ConfigurationStarted"
        $AvmWebrequestBody.InnerBody = "<s:NewSessionID>{0}</s:NewSessionID>" -f $NewSessionID
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