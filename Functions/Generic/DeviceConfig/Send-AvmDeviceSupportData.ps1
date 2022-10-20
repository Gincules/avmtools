function Send-AvmDeviceSupportData {
    <#
        .SYNOPSIS
            Send FRITZ!Box support data to AVM
        .DESCRIPTION
            Send FRITZ!Box support data to AVM
        .PARAMETER RemoteAccess
            Access FRITZ!Box from the internet
        .PARAMETER Insecure
            Use unencrypted authentication over http instead of https
        .PARAMETER RemoteAccess
            Access FRITZ!Box from the internet
        .PARAMETER Url
            Url of FRITZ!Box
        .PARAMETER Port
            Port of FRITZ!Box
        .PARAMETER Credential
            PSCredential variable
        .PARAMETER DataType
            Argument list of action DataType
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Send-AvmDeviceSupportData -Url "https://fritz.box" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Send-AvmDeviceSupportData -Insecure -Url "http://fritz.box" -Port 49000 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Send-AvmDeviceSupportData -Url "https://192.168.178.1" -Port 49443 -Credential $Credential
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Send-AvmDeviceSupportData -Insecure -Url "http://192.168.178.1" -Port 49000 -Credential $Credential
    #>

    Param
    (
        [switch]$Insecure = $false,
        [switch]$RemoteAccess = $false,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential,
        [Parameter(Mandatory=$true)][ValidateSet("normal","mesh","unknown")][string]$DataMode
    )

    Begin {
        $avmWebrequestBody = [AvmBody]::new()

        $avmWebrequestBody.SoapAction = "urn:dslforum-org:service:DeviceConfig:1"
        $avmWebrequestBody.Action = "X_AVM-DE_SendSupportData"
        $avmWebrequestBody.InnerBody = "<s:NewX_AVM-DE_SupportDataMode>{0}</s:NewX_AVM-DE_SupportDataMode>" -f $DataMode

        [xml]$avmBodyParameter = $avmWebrequestBody.GenerateBody()
        [string]$SoapAction = $avmWebrequestBody.GenerateSoapAction()
    }

    Process {
        $splatParameters = @{
            Insecure = $Insecure
            Url = $Url
            Port = $Port
            Credential = $Credential
            Body = $avmBodyParameter
            SoapAction = $SoapAction
            UrlPath = "$(if ($RemoteAccess) { "/tr064" })/upnp/control/deviceconfig"
            XmlResponse = "X_AVM-DE_SendSupportDataResponse"
        }

        Invoke-AvmAction @splatParameters
    }
}