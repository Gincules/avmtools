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
            $securePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
            $plainNewPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($securePointer)
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($securePointer)
        }

        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:DeviceConfig:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
        $avmWebrequestBody.Action = "X_AVM-DE_GetConfigFile"
        $avmWebrequestBody.InnerBody = "<s:NewX_AVM-DE_Password>{0}</s:NewX_AVM-DE_Password>" -f $plainNewPassword
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