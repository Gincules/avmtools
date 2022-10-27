function Set-AvmWanConfig {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmWanConfig
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmWanConfig
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmWanConfig
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
        [System.String]$NewMaxBitRate,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewChannel,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewSSID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewBeaconType,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewMacAddressControlEnabled,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewBasicEncryptionModes,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewBasicAuthenticationMode
    )
    
    Begin {
        $avmWebrequestBody = [AvmBody]::new()
    
        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:WLANConfiguration:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/wlanconfig1"
        $avmWebrequestBody.Action = "SetConfig"
        $avmWebrequestBody.InnerBody = @"
<s:NewMaxBitRate>{0}</s:NewMaxBitRate>
<s:NewChannel>{1}</s:NewChannel>
<s:NewSSID>{2}</s:NewSSID>
<s:NewBeaconType>{3}</s:NewBeaconType>
<s:NewMacAddressControlEnabled>{4}</s:NewMacAddressControlEnabled>
<s:NewBasicEncryptionModes>{5}</s:NewBasicEncryptionMode>
<s:NewBasicAuthenticationMode>{6}</s:NewBasicAuthenticationMode>
"@ -f $NewMaxBitRate, $NewChannel, $NewSSID, $NewBeaconType, $NewMacAddressControlEnabled, $NewBasicEncryptionModes, $NewBasicAuthenticationMode
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
