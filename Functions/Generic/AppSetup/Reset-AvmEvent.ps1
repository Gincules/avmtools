function Reset-AvmEvent {
    <#
        .SYNOPSIS
            Reset FRITZ!Box app event by id
        .DESCRIPTION
            Resets FRITZ!Box app event by id
        .PARAMETER Insecure
            Use unencrypted authentication over http instead of https
        .PARAMETER Url
            Url of FRITZ!Box
        .PARAMETER Port
            Port of FRITZ!Box
        .PARAMETER Credential
            PSCredential variable
        .PARAMETER EventId
            Identifier of the event instance
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Reset-AvmEvent -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Reset-AvmEvent -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Reset-AvmEvent -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Reset-AvmEvent -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
    #>

    Param
    (
        [switch]$Insecure = $false,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$EventId
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:X_AVM-DE_AppSetup:1"
        $avmWebrequestBody.Action = "ResetEvent"
        $avmWebrequestBody.InnerBody = "<s:NewEventId>{0}</s:NewEventId>" -f $EventId

        [xml]$avmBodyParameter = $avmWebrequestBody.GenerateBody()
        [string]$soapAction = $avmWebrequestBody.GenerateSoapAction()
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            Body = $avmBodyParameter
            SoapAction = $soapAction
            UrlPath = "/upnp/control/x_appsetup"
            XmlResponse = "ResetEventResponse"
        }

        Invoke-AvmAction @splatParameters
    }
}