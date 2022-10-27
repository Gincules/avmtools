function Set-AvmWlanHybridMode {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmWlanHybridMode
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmWlanHybridMode
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmWlanHybridMode
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
        [System.String]$NewEnable,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewBeaconType,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]$NewKeyPassphrase,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewSSID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewBSSID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewTrafficMode,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewManualSpeed,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewMaxSpeedDS,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewMaxSpeedUS
    )
    
    Begin {
        $securePointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewKeyPassphrase)
        $plainNewKeyPassphrase = [Runtime.InteropServices.Marshal]::PtrToStringAuto($securePointer)
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($securePointer)

        $avmWebrequestBody = [AvmBody]::new()
    
        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:WLANConfiguration:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/wlanconfig1"
        $avmWebrequestBody.Action = "X_AVM-DE_SetWLANHybridMode"
        $avmWebrequestBody.InnerBody = @"
<s:NewEnable>{0}</s:NewEnable>
<s:NewBeaconType>{1}</s:NewBeaconType>
<s:NewKeyPassphrase>{2}</s:NewKeyPassphrase>
<s:NewSSID>{3}</s:NewSSID>
<s:NewBSSID>{4}</s:NewBSSID>
<s:NewTrafficMode>{5}</s:NewTrafficMode>
<s:NewManualSpeed>{6}</s:NewManualSpeed>
<s:NewMaxSpeedDS>{6}</s:NewMaxSpeedDS>
<s:NewMaxSpeedUS>{7}</s:NewMaxSpeedUS>
"@ -f $NewEnable, $NewBeaconType, $plainNewKeyPassphrase, $NewSSID, $NewBSSID, $NewTrafficMode, $NewManualSpeed, $NewMaxSpeedDS, $NewMaxSpeedUS
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
    
        Connect-AvmDevice @splatParameters
    }
}
