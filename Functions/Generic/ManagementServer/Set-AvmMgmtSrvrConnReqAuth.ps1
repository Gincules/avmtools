function Set-AvmMgmtSrvrConnReqAuth {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmMgmtSrvrConnReqAuth
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmMgmtSrvrConnReqAuth
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmMgmtSrvrConnReqAuth
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
        [System.String]$NewConnectionRequestUsername,

        [Parameter()]
        [System.Security.SecureString]$NewConnectionRequestPassword
    )

    Begin {
        if (-Not ([System.String]::IsNullOrEmpty($NewConnectionRequestPassword))) {
            $securePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewConnectionRequestPassword)
            $plainNewConnectionRequestPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($securePointer)
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($securePointer)
        }

        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:ManagementServer:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/mgmsrv"
        $avmWebrequestBody.Action = "SetConnectionRequestAuthentication"
        $avmWebrequestBody.InnerBody = @"
<s:NewConnectionRequestUsername>{0}</s:NewConnectionRequestUsername>
<s:NewConnectionRequestPassword>{1}</s:NewConnectionRequestPassword>
"@ -f $NewConnectionRequestUsername, $plainNewConnectionRequestPassword
    }

    Process {
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
}