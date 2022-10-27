function Set-AvmManagementServerUsername {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmManagementServerUsername
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmManagementServerUsername
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmManagementServerUsername
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
        [SecureString]$NewPassword
    )

    Begin {
        if (-Not ([System.String]::IsNullOrEmpty($NewPassword))) {
            $securePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
            $plainNewPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($securePointer)
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($securePointer)
        }

        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:ManagementServer:1"
        $avmWebrequestBody.SoapAction = UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/mgmsrv"
        $avmWebrequestBody.Action = "SetManagementServerPassword"
        $avmWebrequestBody.InnerBody = "<s:NewPassword>{0}</s:NewPassword>" -f $plainNewPassword
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
