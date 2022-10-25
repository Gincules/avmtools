function Invoke-AvmAction {
    <#
        .SYNOPSIS
            Wiki: https://github.com/Gincules/avmtools/wiki
        .DESCRIPTION
            Wiki: https://github.com/Gincules/avmtools/wiki
        .NOTES
            Author: Gincules
            Website: https://github.com/Gincules/avmtools
            License: https://github.com/Gincules/avmtools/blob/main/LICENSE
        .LINK
            https://github.com/Gincules/avmtools
            https://github.com/Gincules/avmtools/blob/main/LICENSE
        .EXAMPLE
            Wiki: https://github.com/Gincules/avmtools/wiki
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