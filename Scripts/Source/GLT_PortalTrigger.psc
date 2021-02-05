Scriptname GLT_PortalTrigger extends ObjectReference

GLT_RecoveryScript Property RecoveryTrigger Auto
ObjectReference Property RecoveryPoint Auto

Event OnTriggerEnter(ObjectReference ref)
	(getLinkedRef() as GLT_PortalManager).goLive()
	if(RecoveryPoint)
		RecoveryTrigger.LastRecoveryPoint = RecoveryPoint
	endIf
endEvent