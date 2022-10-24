class AvmBody {
    [System.String]$Action
    [System.String]$InnerBody
    [System.String]$SoapAction
    [System.String]$UrlPath

    [System.Xml.XmlDocument]GenerateBody() {
        return '<?xml version="1.0" encoding="utf-8"?><s:Envelope s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body><u:{1} xmlns:u="{0}">{2}</u:{1}></s:Body></s:Envelope>' -f $this.SoapAction, $this.Action, $this.InnerBody
    }

    [System.String]GenerateSoapAction() {
        return "{0}#{1}" -f $this.SoapAction, $this.Action
    }

    [System.String]GenerateXmlResponse() {
        return "{0}Response" -f $this.Action
    }
}