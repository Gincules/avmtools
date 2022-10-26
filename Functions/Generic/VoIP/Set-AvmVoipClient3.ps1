function Set-AvmVoipClient3 {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipClient3
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipClient3
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmVoipClient3
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
        [System.String]$NewClientIndex,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewClientPassword,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewPhoneName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$ClientId,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewOutGoingNumber,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewInComingNumbers,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewExternalRegistration
    )

    Begin {
        $securePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewClientPassword)
        $NewClientPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($securePointer)
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($securePointer)

        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_VoIP:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_voip"
        $avmWebrequestBody.Action = "X_AVM-DE_SetClient3"
        $avmWebrequestBody.InnerBody = @"
<s:NewX_AVM-DE_ClientIndex>{0}</s:NewX_AVM-DE_ClientIndex>
<s:NewX_AVM-DE_ClientPassword>{1}</s:NewX_AVM-DE_ClientPassword>
<s:NewX_AVM-DE_PhoneName>{2}</s:NewX_AVM-DE_PhoneName>
<s:NewX_AVM-DE_ClientId >{3}</s:NewX_AVM-DE_ClientId >
<s:NewX_AVM-DE_OutGoingNumber>{4}</s:NewX_AVM-DE_OutGoingNumber>
<s:NewX_AVM-DE_InComingNumbers>{5}</s:NewX_AVM-DE_InComingNumbers>
<s:NewX_AVM-DE_ExternalRegistration>{6}</s:NewX_AVM-DE_ExternalRegistration>
"@ -f $NewClientIndex, $plainNewClientPassword, $NewPhoneName, $ClientId, $NewOutGoingNumber, $NewInComingNumbers, $NewExternalRegistration
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