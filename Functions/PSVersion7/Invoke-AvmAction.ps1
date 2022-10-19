function Invoke-AvmAction {
	<#
        .SYNOPSIS
            Base function for avmtool commands with IN parameters
        .DESCRIPTION
            This function is required for avmtool commands with IN parameters
        .PARAMETER Insecure
            Use unencrypted authentication over http instead of https
        .PARAMETER Url
            Url of FRITZ!Box
        .PARAMETER Port
            Port of FRITZ!Box
        .PARAMETER Credential
            PSCredential variable
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            PS C:\> [PSCredential]$Credential = Get-Credential
            PS C:\> Connect-AvmDevice -Url "https://myfritzaddress12.myfritz.net" -Port 443 -Credential $Credential -SoapAction "urn:dslforum-org:service:DeviceInfo:1#GetSecurityPort" -UrlPath "/tr064/upnp/control/deviceinfo" -XmlResponse "GetSecurityPortResponse"
    #>

	Param
	(
		[switch]$Insecure,
		[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Url,
		[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][int32]$Port,
		[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][PSCredential]$Credential,
		[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$UrlPath,
		[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$SoapAction,
		[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][xml]$Body,
		[Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$XmlResponse
	)

	Begin {
		$splatParameters = @{
			Uri = $Url + ":" + $Port + $UrlPath
			Method = "Post"
			StatusCodeVariable = "statusCode"
			Credential = $Credential
			ContentType = "text/xml;charset=utf-8"
			Body = $Body
					
			Headers = @{
				"SoapAction" = $SoapAction
				"User-Agent" = "AVM UPnP/1.0 Client 1.0"
			}
		}
	}

	Process {
		# PowerShell 7.2
		if ($Insecure) {
			[xml]$avmResponse = Invoke-RestMethod @splatParameters -AllowUnencryptedAuthentication -WarningAction:SilentlyContinue -ErrorAction:SilentlyContinue
		} else {
			[xml]$avmResponse = Invoke-RestMethod @splatParameters -WarningAction:SilentlyContinue -ErrorAction:SilentlyContinue
		}
	}

	End {
		return ($statusCode -eq 200) ? $avmResponse.Envelope.Body.$XmlResponse : $false
	}
}