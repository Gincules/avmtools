function Connect-AvmDevice {
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
        [System.Management.Automation.SwitchParameter]$Insecure,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$Url,

        [Parameter(Mandatory)]
        [ValidateRange(0,65535)]
        [System.UInt16]$Port,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$UrlPath,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$SoapAction,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]$XmlResponse,

        [Parameter()]
        $Body = $null
    )

    Begin {
        # if body is $null a universal (for PowerShell not valid) xml will be assigned as string for body
        $Body ??= '<?xml version="1.0"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><s:Body><u:Response/></s:Body></s:Envelope>' -as [System.String]

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

            ErrorAction = "SilentlyContinue"
            WarningAction = "SilentlyContinue"
            ErrorVariable = "responseError"
        }
    }

    Process {
        # PowerShell 7.2
        # call TR-064 api and catch error
        [System.Object]$webResponse = `
            Try { `
                if ($Insecure) { `
                    [System.Xml.XmlDocument]$avmResponse = Invoke-RestMethod @splatParameters -AllowUnencryptedAuthentication `
                } else { `
                    [System.Xml.XmlDocument]$avmResponse = Invoke-RestMethod @splatParameters `
                } `
            } Catch { `
                $_.Exception.Response `
            }
        }

    End {
        # if http status code is 200 (OK) return XML of FRITZ!Box response, else return http exeption response and response error
        return ($statusCode -eq 200) ? $avmResponse.Envelope.Body.$XmlResponse : $webResponse, $responseError
    }
}