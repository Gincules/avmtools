function Set-AvmAppMessageReceiver {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppMessageReceiver
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppMessageReceiver
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmAppMessageReceiver
    #>

    Param
    (
        [Alias("i")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$Insecure = $false,

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
        [System.String]$NewAppId,

        [Parameter()]
        [System.String]$NewCryptAlgos,

        [Parameter()]
        [System.String]$NewAppAVMAddress,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewAppAVMPasswordHash
    )

    Begin {
        $securePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewAppAVMPasswordHash)
        $plainNewAppAVMPasswordHash = [Runtime.InteropServices.Marshal]::PtrToStringAuto($securePointer)
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($securePointer)

        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
        $avmWebrequestBody.UrlPath = "/upnp/control/x_appsetup"
        $avmWebrequestBody.Action = "SetAppMessageReceiver"
        $avmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewCryptAlgos>{1}</s:NewCryptAlgos>
<s:NewAppAVMAddress>{2}</s:NewAppAVMAddress>
<s:NewAppAVMPasswordHash>{3}</s:NewAppAVMPasswordHash>
"@ -f $NewAppId, $NewCryptAlgos, $NewAppAVMAddress, $plainNewAppAVMPasswordHash
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