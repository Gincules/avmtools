function Register-AvmApp {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Register-AvmApp
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Register-AvmApp
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Register-AvmApp
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

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewAppDisplayName,

        [Parameter()]
        [System.String]$NewAppDeviceMAC,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [PSCredential]$NewAppCredential,

        [Parameter(Mandatory)]
        [ValidateSet("NO","RO","RW","UNDEFINED",0,2,4)]
        [RightEnum]$NewAppRight,

        [Parameter(Mandatory)]
        [ValidateSet("NO","RO","RW","UNDEFINED",0,2,4)]
        [RightEnum]$NewNasRight,

        [Parameter(Mandatory)]
        [ValidateSet("NO","RO","RW","UNDEFINED",0,2,4)]
        [RightEnum]$NewPhoneRight,

        [Parameter(Mandatory)]
        [ValidateSet("NO","RO","RW","UNDEFINED",0,2,4)]
        [RightEnum]$NewHomeautoRight,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.SByte][System.Boolean]$NewAppInternetRights
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
        $avmWebrequestBody.UrlPath = "/upnp/control/x_appsetup"
        $avmWebrequestBody.Action = "RegisterApp"
        $avmWebrequestBody.InnerBody = @"
<s:NewAppId>{0}</s:NewAppId>
<s:NewAppDisplayName>{1}</s:NewAppDisplayName>
<s:NewAppDeviceMAC>{2}</s:NewAppDeviceMAC>
<s:NewAppUsername>{3}</s:NewAppUsername>
<s:NewAppPassword>{4}</s:NewAppPassword>
<s:NewAppRight>{5}</s:NewAppRight>
<s:NewNasRight>{6}</s:NewNasRight>
<s:NewPhoneRight>{7}</s:NewPhoneRight>
<s:NewHomeautoRight>{8}</s:NewHomeautoRight>
<s:NewAppInternetRights>{9}</s:NewAppInternetRights>
"@ -f $NewAppId, $NewAppDisplayName, $NewAppDeviceMAC, $NewAppCredential.GetNetworkCredential().UserName, $NewAppCredential.GetNetworkCredential().Password, $NewAppRight, $NewNasRight, $NewPhoneRight, $NewHomeautoRight, $NewAppInternetRights
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

        Invoke-AvmAction @splatParameters
    }
}