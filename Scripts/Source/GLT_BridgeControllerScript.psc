scriptname GLT_BridgeControllerScript extends ObjectReference


EffectShader Property Disintegrate Auto
EffectShader Property UnDisintegrate Auto
Actor Property PlayerRef Auto

GLT_RecoveryScript Property RecoveryTrigger Auto
ObjectReference Property RecoveryPoint Auto
float rX
float rY
float rZ

Event OnInit()
	ObjectReference ref = getLinkedRef()
	rX = ref.X
	rY = ref.Y
	rZ = ref.Z
endEvent

state active
	Event OnTriggerLeave(ObjectReference akActionRef)
		if(akActionRef == PlayerRef)
			goToState("dormant")
		endIf
	endEvent
	Event OnBeginState()
		ObjectReference ref = getLinkedRef()
		ref.setPosition(rX, rY, rZ)
		UnDisintegrate.play(ref, 0.6)
		Disintegrate.stop(ref)
	endEvent
endState
auto state dormant
	Event OnTriggerEnter(ObjectReference akActionRef)
		if(akActionRef == PlayerRef)
			goToState("active")
			if(RecoveryPoint)
				RecoveryTrigger.LastRecoveryPoint = RecoveryPoint
			endIf
		endIf
	endEvent
	Event OnBeginState()
		ObjectReference ref = getLinkedRef()
		Disintegrate.play(ref)
		;UnDisintegrate.stop(ref)
		ref.setPosition(0, 0, 0)
	endEvent
endState