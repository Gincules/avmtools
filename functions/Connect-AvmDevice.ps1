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
        # switch case to be removed in the future and replaced with this - but the TR-064 response documentation is weak
        #return $avmResponse.Envelope.Body.$XmlResponse

        switch ($XmlResponse)
        {
            "GetAddressRangeResponse" { return $avmResponse.Envelope.Body.GetAddressRangeResponse; Break }
            "GetAppRemoteInfoResponse" { return $avmResponse.Envelope.Body.GetAppRemoteInfoResponse; Break }
            "GetCommonLinkPropertiesResponse" { return $avmResponse.Envelope.Body.GetCommonLinkPropertiesResponse; Break }
            "GetConnectionTypeInfoResponse" { return $avmResponse.Envelope.Body.GetConnectionTypeInfoResponse; Break }
            "GetDeviceLogResponse" { return $avmResponse.Envelope.Body.GetDeviceLogResponse; Break }
            "GetExternalIPAddressResponse" { return $avmResponse.Envelope.Body.GetExternalIPAddressResponse; Break }
            "GetInfoResponse" { return $avmResponse.Envelope.Body.GetInfoResponse; Break }
            "GetIPInterfaceNumberOfEntriesResponse" { return $avmResponse.Envelope.Body.GetIPInterfaceNumberOfEntriesResponse; Break }
            "GetIPRoutersListResponse" { return $avmResponse.Envelope.Body.GetIPRoutersListResponse; Break }
            "GetNATRSIPStatusResponse" { return $avmResponse.Envelope.Body.GetNATRSIPStatusResponse; Break }
            "GetPersistentDataResponse" { return $avmResponse.Envelope.Body.GetPersistentDataResponse; Break }
            "GetPortMappingNumberOfEntriesResponse" { return $avmResponse.Envelope.Body.GetPortMappingNumberOfEntriesResponse; Break }
            "GetSecurityPortResponse" { return $avmResponse.Envelope.Body.GetSecurityPortResponse; Break }
            "GetStatisticsResponse" { return $avmResponse.Envelope.Body.GetStatisticsResponse; Break }
            "GetStatusInfoResponse" { return $avmResponse.Envelope.Body.GetStatusInfoResponse; Break }
            "GetSubnetMaskResponse" { return $avmResponse.Envelope.Body.GetSubnetMaskResponse; Break }
            "GetTotalBytesReceivedResponse" { return $avmResponse.Envelope.Body.GetTotalBytesReceivedResponse; Break }
            "GetTotalBytesSentResponse" { return $avmResponse.Envelope.Body.GetTotalBytesSentResponse; Break }
            "GetTotalPacketsReceivedResponse" { return $avmResponse.Envelope.Body.GetTotalPacketsReceivedResponse; Break }
            "GetTotalPacketsSentResponse" { return $avmResponse.Envelope.Body.GetTotalPacketsSentResponse; Break }
            "X_AVM-DE_GetAnonymousLoginResponse" { return $avmResponse.Envelope.Body."X_AVM-DE_GetAnonymousLoginResponse"; Break }
            "X_AVM-DE_GetChangeCounterResponse" { return $avmResponse.Envelope.Body."X_AVM-DE_GetChangeCounterResponse"; Break }
            "X_AVM-DE_GetCurrentUserResponse" { return $avmResponse.Envelope.Body."X_AVM-DE_GetCurrentUserResponse"; Break }
            "X_AVM-DE_GetHostListPathResponse" { return $avmResponse.Envelope.Body."X_AVM-DE_GetHostListPathResponse"; Break }
            "X_AVM-DE_GetMeshListPathResponse" { return $avmResponse.Envelope.Body."X_AVM-DE_GetMeshListPathResponse"; Break }
            "X_AVM-DE_GetSupportDataInfoResponse" { return $avmResponse.Envelope.Body."X_AVM-DE_GetSupportDataInfoResponse"; Break }
            "X_AVM-DE_GetUserListResponse" { return $avmResponse.Envelope.Body."X_AVM-DE_GetUserListResponse"; Break }
            "X_GenerateUUIDResponse" { return $avmResponse.Envelope.Body."X_GenerateUUIDResponse"; Break }
            "X_GetDNSServersResponse" { return $avmResponse.Envelope.Body."X_GetDNSServersResponse"; Break }

            # default
            default { return $avmResponse.Envelope.Body }
        }
    }
}