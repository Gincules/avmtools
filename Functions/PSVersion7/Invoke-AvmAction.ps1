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
		[Alias("i")]
		[Parameter()]
		[System.Management.Automation.SwitchParameter]$Insecure,
	
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
	
		# since U for url and P for path, S for segemet or subdirectory is already taken - D like directory
		[Alias("d")]
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$UrlPath,
	
		[Alias("s")]
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.String]$SoapAction,
	
		[Alias("b")]
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.Xml.XmlNode]$Body,
	
		[Alias("x")]
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
			[System.String]$statusDescription = $webResponse.StatusCode
			
			# System.Text.StringBuilder would be the better variable type to avoid += operator, might be replaced in the future
			#[System.Text.StringBuilder]$statusDescription = $webResponse.StatusCode
			
			# remove all the new lines from error message
			$statusDescription += " (" + ($webError.Message -Replace("`n`n| ") -Replace "`n", " ").Trim() + ")"
		}
		
		# use XML for consistency
		[System.Xml.XmlDocument]$statusXml = '<?xml version="1.0"?><Envelope><Body><{0}><statusCode>{1}</statusCode><statusDescription>{2}</statusDescription></{0}></Body></Envelope>' -f $XmlResponse, $statusCode, $statusDescription
		
		# since the object would be recreated every run of the for-loop with += operator, System.Collections.ArrayList instead of System.Array being used
		[System.Collections.ArrayList]$finalResult = @()
		#[System.Array]$finalResult = @()
		
		# append response of AVM device
		ForEach ($object in $avmResponse.Envelope.Body.$XmlResponse) {
			[System.Void]$finalResult.Add($object)
			#$finalResult += $object
		}
		
		# append status code and message
		ForEach ($object in $statusXml.Envelope.Body.$XmlResponse) {
			[System.Void]$finalResult.Add($object)
			#$finalResult += $object
		}
	}
	
	End {
		# return the result or $false if empty
		return (! ([System.String]::IsNullOrEmpty($finalResult))) ? $finalResult : $false
	}
}