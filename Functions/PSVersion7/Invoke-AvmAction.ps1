# example for later used actions with IN direction

$action = "GetSecurityPort"
$urn = "urn:dslforumorg:service:DeviceInfo"
$value = 1

[xml]$request = @'
<?xml version="1.0"?>
<s:Envelope
	xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
	<s:Body>
		<u:{0}
			xmlns:u="{1}:{2}">
		</u:{0}>
	</s:Body>
</s:Envelope>
'@ -f $action, $urn, $value

#$request.Envelope.Body.GetSecurityPort
$request | Out-Null
