function Add-AvmVoipAccount {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Add-AvmVoipAccount
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Add-AvmVoipAccount
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Add-AvmVoipAccount
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
        [System.Management.Automation.PSCredential]$NewVOIPCredential,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$NewVoIPAccountIndex,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewVoIPRegistrar,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewVoIPNumber,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewVoIPOutboundProxy,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$NewVoIPSTUNServer
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_VoIP:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_voip"
        $avmWebrequestBody.Action = "X_AVM-DE_AddVoIPAccount"
        $avmWebrequestBody.InnerBody = @"
<s:NewVoIPAccountIndex>{0}</s:NewVoIPAccountIndex>
<s:NewVoIPRegistrar>{1}</s:NewVoIPRegistrar>
<s:NewVoIPNumber>{2}</s:NewVoIPNumber>
<s:NewVoIPUsername>{3}</s:NewVoIPUsername>
<s:NewVoIPPassword>{4}</s:NewVoIPPassword>
<s:NewVoIPOutboundProxy>{5}</s:NewVoIPOutboundProxy>
<s:NewVoIPSTUNServer>{6}</s:NewVoIPSTUNServer>
"@ -f $NewVoIPAccountIndex, $NewVoIPRegistrar, $NewVoIPNumber, $NewVOIPCredential.GetNetworkCredential().UserName, $NewVOIPCredential.GetNetworkCredential().Password, $NewVoIPOutboundProxy, $NewVoIPSTUNServer
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
