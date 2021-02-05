Scriptname GLT_SkyrimSelectionGatewayTrigger extends GLT_GatewayTrigger

GLTQ01 property Chargen auto

Event OnTriggerEnter(ObjectReference akActionRef)
	Chargen.leaveSkyrimWorldspace()
	parent.OnTriggerEnter(akActionRef)
endEvent