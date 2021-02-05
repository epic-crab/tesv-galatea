scriptname GLT_HengeGlowScript extends ObjectReference

EffectShader Property RuneGlow Auto
Actor Property PlayerRef Auto
bool property multimode auto
ObjectReference[] Property Henges Auto

GLT_RecoveryScript Property RecoveryTrigger Auto
ObjectReference Property RecoveryPoint Auto

state glowing
	Event OnTriggerLeave(ObjectReference akActionRef)
		if(akActionRef == PlayerRef)
			goToState("dormant")
		endIf
	endEvent
	Event OnBeginState()
		if(!multimode)
			RuneGlow.play(getLinkedRef())
		else
			int i = 0
			while i < Henges.length
				RuneGlow.play(Henges[i])
				i += 1
			endWhile
		endIf
	endEvent
	Event OnEndState()
		if(!multimode)
			RuneGlow.stop(getLinkedRef())
		else
			int i = 0
			while i < Henges.length
				RuneGlow.stop(Henges[i])
				i += 1
			endWhile
		endIf
	endEvent
endState
auto state dormant
	Event OnTriggerEnter(ObjectReference akActionRef)
		if(akActionRef == PlayerRef)
			goToState("glowing")
			if(RecoveryPoint)
				RecoveryTrigger.LastRecoveryPoint = RecoveryPoint
			endIf
		endIf
	endEvent
endState