function Remove-AvmOnTelPhoneEntryByUid {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelPhoneEntryByUid
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelPhoneEntryByUid
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Remove-AvmOnTelPhoneEntryByUid
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
        [string]$NewPhonebookID,

        [Parameter()]
        [string]$NewPhonebookEntryUniqueID
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        $avmWebrequestBody.Action = "DeletePhonebookEntryUID"
        $avmWebrequestBody.InnerBody = @"
<s:NewPhonebookID>{0}</s:NewPhonebookID>
<s:NewPhonebookEntryUniqueID>{1}</s:NewPhonebookEntryUniqueID>
"@ -f $NewPhonebookID, $NewPhonebookEntryUniqueID
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
