function Set-AvmOnTelPhonebookEntry {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelPhonebookEntry
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelPhonebookEntry
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki/Set-AvmOnTelPhonebookEntry
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
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookID,

        [Parameter()]
        [ValidateRange(0,4294967295)]
        [System.UInt32]$NewPhonebookEntryID,

        [Parameter()]
        [System.String]$NewPhonebookEntryData
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_OnTel:1"
        $avmWebrequestBody.UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/x_contact"
        $avmWebrequestBody.Action = "SetPhonebookEntry"
        $avmWebrequestBody.InnerBody = @"
<s:NewPhonebookID>{0}</s:NewPhonebookID>
<s:NewPhonebookEntryID>{1}</s:NewPhonebookEntryID>
<s:NewPhonebookEntryData>{2}</s:NewPhonebookEntryData>
"@ -f $NewPhonebookID, $NewPhonebookExtraID, $NewPhonebookEntryData
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