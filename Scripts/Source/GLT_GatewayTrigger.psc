scriptname GLT_GatewayTrigger extends ObjectReference

ObjectReference Property TargetHenge Auto
Actor Property PlayerRef Auto

GLT_RecoveryScript Property RecoveryTrigger Auto

Event OnTriggerEnter(ObjectReference akActionRef)
	if(akActionRef == PlayerRef)
		akActionRef.moveTo(TargetHenge)
		RecoveryTrigger.LastRecoveryPoint = TargetHenge
	endIf
endEvent