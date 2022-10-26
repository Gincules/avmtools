function Set-AvmStorageUserConfig {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmStorageUserConfig
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmStorageUserConfig
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmStorageUserConfig
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
        [System.Byte][System.Boolean]$NewEnable = 0,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewPassword,

        [Parameter()]
        [System.Byte][System.Boolean]$NewNetworkAccessReadOnly = 0
    )

    Begin {
        $securePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
        $plainNewPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($securePointer)
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($securePointer)

        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_Storage:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_storage"
        $avmWebrequestBody.Action = "SetUserConfig"
        $avmWebrequestBody.InnerBody = @"
<s:NewEnable>{0}</s:NewEnable>
<s:NewPassword>{1}</s:NewPassword>
<s:NewX_AVM-DE_NetworkAccessReadOnly>{2}</s:NewX_AVM-DE_NetworkAccessReadOnly>
"@ -f $NewEnable, $plainNewPassword, $NewFTPWANSSLOnly
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            SoapAction = $avmWebrequestBody.GenerateSoapAction()
            UrlPath = $avmWebrequestBody.UrlPath
            Body = $avmWebrequestBody.GenerateBody()
            XmlResponse = $avmWebrequestBody.GenerateXmlResponse()
        }

        Invoke-AvmAction @splatParameters
    }
}