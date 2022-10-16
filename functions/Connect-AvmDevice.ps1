function Connect-AvmDevice {
    Param
    (
        [switch]$Insecure,
        [string]$Url,
        [int32]$Port,
        [PSCredential]$Credential,
        [string]$UrlPath,
        [string]$SoapAction,
        [string]$XmlResponse
    )

    $splatParameters = @{
        Uri = $Url + ":" + $Port + $UrlPath
        Method = "Post"
        StatusCodeVariable = "statusCode"
        Credential = $Credential
        ContentType = "text/xml;charset=utf-8"
        Body = '<?xml version="1.0"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><s:Body><u:Response/></s:Body></s:Envelope>'
                
        Headers = @{
            "SoapAction" = $SoapAction
            "User-Agent" = "AVM UPnP/1.0 Client 1.0"
        }
    }

    if ($Insecure) {
        [xml]$avmResponse = (Invoke-RestMethod @splatParameters -AllowUnencryptedAuthentication)
    } else {
        [xml]$avmResponse = (Invoke-RestMethod @splatParameters)
    }

    if ($statusCode -eq 200) {
        #return $avmResponse.Envelope.Body."$XmlResponse"
        return $avmResponse.Envelope.Body.$XmlResponse
    }
}