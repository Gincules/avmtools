class AvmBody {
    [string]$Action
    [string]$InnerBody
    [string]$SoapAction

    [xml]GenerateBody() {
        return '<?xml version="1.0" encoding="utf-8"?><s:Envelope s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body><u:{1} xmlns:u="{0}">{2}</u:{1}></s:Body></s:Envelope>' -f $this.SoapAction, $this.Action, $this.InnerBody
    }
}