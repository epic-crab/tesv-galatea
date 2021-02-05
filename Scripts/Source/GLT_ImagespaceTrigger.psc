Scriptname GLT_ImagespaceTrigger extends ObjectReference  

ImagespaceModifier Property AreaIS Auto
ObjectReference Property LocalStuffEnabler Auto
Actor Property PlayerRef Auto

GLT_RecoveryScript Property RecoveryTrigger Auto
ObjectReference Property RecoveryPoint Auto

Event OnTriggerEnter(ObjectReference ref)
	if(ref == PlayerRef)
		AreaIS.applyCrossFade()
		if(LocalStuffEnabler)
			LocalStuffEnabler.enable()
		endIf
		if(RecoveryPoint)
			RecoveryTrigger.LastRecoveryPoint = RecoveryPoint
		endIf
	endIf
endEvent

Event OnTriggerLeave(ObjectReference ref)
	if(ref == PlayerRef)
		ImagespaceModifier.removeCrossFade()
		if(LocalStuffEnabler)
			LocalStuffEnabler.disable()
		endIf
	endIf
endEvent