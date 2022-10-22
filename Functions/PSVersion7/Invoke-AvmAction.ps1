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
		[Alias("I","i")]
		[Parameter()]
		[System.Management.Automation.SwitchParameter]$Insecure,

		[Alias("U","u")]
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$Url,

		[Alias("P","p")]
		[Parameter(Mandatory)]
		[ValidateRange(0,65535)]
		[System.UInt16]$Port,

		[Alias("C","c")]
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.Management.Automation.PSCredential]$Credential,

		# since U|u for url and P|p for path, S|s for segemet or subdirectory is already taken - D|d like directory
		[Alias("D","d")]
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$UrlPath,

		[Alias("S","s")]
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$SoapAction,

		[Alias("B","b")]
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.Xml.XmlNode]$Body,

		[Alias("X","x")]
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$XmlResponse
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
		# call TR-064 api and catch error
		[System.Object]$webResponse = Try { if ($Insecure) { [System.Xml.XmlDocument]$avmResponse = Invoke-RestMethod @splatParameters -AllowUnencryptedAuthentication -ErrorVariable webError } else { [System.Xml.XmlDocument]$avmResponse = Invoke-RestMethod @splatParameters -ErrorVariable webError }} Catch { $_.Exception.Response }

		# assign status of web request
		if ($statusCode -eq 200) {
			[System.String]$statusDescription = "OK"
		} else {
			$statusCode = $webResponse.StatusCode.value__
			#[System.Text.StringBuilder]$statusDescription = $webResponse.StatusCode
			[System.String]$statusDescription = $webResponse.StatusCode
			
			# remove new lines from error message
			$statusDescription += " (" + ($webError.Message -Replace("`n`n| ") -Replace "`n", " ").Trim() + ")"
		}

		# use XML for consistency
		[System.Xml.XmlDocument]$statusXml = "<?xml version=`"1.0`"?><Envelope><Body><$XmlResponse><statusCode>$statusCode</statusCode><statusDescription>$statusDescription</statusDescription></$XmlResponse></Body></Envelope>"

		[System.Collections.ArrayList]$finalResult = @()

		# append response of AVM device
		ForEach ($object in $avmResponse.Envelope.Body.$XmlResponse) {
			[System.Void]$finalResult.Add($object)
		}

		# append status code and message
		ForEach ($object in $statusXml.Envelope.Body.$XmlResponse) {
			[System.Void]$finalResult.Add($object)
		}
	}

	End {
		# return the result
		return (! ([System.String]::IsNullOrEmpty($finalResult))) ? $finalResult : $false
	}
}