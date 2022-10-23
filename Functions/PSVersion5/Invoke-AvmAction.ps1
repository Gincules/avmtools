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
        .PARAMETER Body
            XML for webrequest body
        .PARAMETER SoapAction
            service Type
        .PARAMETER UrlPath
            control URL
        .PARAMETER XmlResponse
            service response
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
		[Parameter()]
		[switch]$Insecure,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$Url,

		[Parameter(Mandatory)]
		[ValidateRange(0,65535)]
		[System.UInt16]$Port,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$UrlPath,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$SoapAction,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.Xml.XmlDocument]$Body,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$XmlResponse
	)

	Begin {
		$splatParameters = @{
			Uri = $Url + ":" + $Port + $UrlPath
			Method = "Post"
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
        # PowerShell 5.1
		[System.Net.WebResponse]$webResponse = try { [System.Xml.XmlDocument]$avmResponse = Invoke-RestMethod @splatParameters -ErrorVariable webError } catch { $_.Exception.Response }

		[System.UInt16]$statusCode = $webResponse.StatusCode.value__ 
		[System.String]$statusDescription = $webResponse.StatusDescription

		if ($statusCode -eq 0) {
			$statusCode = 200
			$statusDescription = "OK"
		} else {
			$statusCode = $webResponse.StatusCode.value__
			[System.String]$statusDescription = $webResponse.StatusCode

			$statusDescription += " (" + ($webError.Message -Replace("`n`n| ") -Replace "`n", " ").Trim() + ")"
		}

		[System.Xml.XmlDocument]$statusXml = "<?xml version=`"1.0`"?><Envelope><Body><$XmlResponse><statusCode>$statusCode</statusCode><statusDescription>$statusDescription</statusDescription></$XmlResponse></Body></Envelope>"

		[System.Array]$finalResult = @()

		$avmResponse.Envelope.Body.$XmlResponse | Select-Object | ForEach-Object {
			$finalResult += $_
		}

		$statusXml.Envelope.Body.$XmlResponse | Select-Object | ForEach-Object {
			$finalResult += $_
		}
    }

    End {
		if (-Not ([System.String]::IsNullOrEmpty($finalResult))) {
			return $finalResult
		} else {
			return $false
		}
    }
}