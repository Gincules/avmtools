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
        [System.Security.SecureString]$NewPassword,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewConfigFileUrl
    )

    Begin {
        if (-Not ([System.String]::IsNullOrEmpty($NewPassword))) {
            $securePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
            $plainNewPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($securePointer)
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($securePointer)
        }
        
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:DeviceConfig:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        $avmWebrequestBody.Action = "X_AVM-DE_SetConfigFile"
        $avmWebrequestBody.InnerBody = @"
<s:NewX_AVM-DE_Password>{0}</s:NewX_AVM-DE_Password>
<s:NewX_AVM-DE_ConfigFileUrl>{1}</s:NewX_AVM-DE_ConfigFileUrl>
"@ -f $plainNewPassword, $NewConfigFileUrl
    }

    Process {
        $splatParameters = @{
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
}
