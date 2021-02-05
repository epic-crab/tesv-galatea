Scriptname GLT_RecoveryScript extends ObjectReference

Actor Property PlayerRef Auto
ObjectReference Property LastRecoveryPoint Auto
float property time = 0.5 auto
EffectShader Property Disintegrate Auto
EffectShader Property UnDisintegrate Auto

auto state Waiting
	Event OnTriggerEnter(ObjectReference akActionRef)
		if(akActionRef == PlayerRef)
			recover()
		endIf
	endEvent
endState

function recover()
	goToState("Active")
	Game.forceThirdPerson()
	Disintegrate.play(PlayerRef)
	PlayerRef.TranslateToRef(LastRecoveryPoint, PlayerRef.getDistance(LastRecoveryPoint)/time)
	Utility.wait(time)
	UnDisintegrate.play(PlayerRef, 1.5)
	Disintegrate.stop(PlayerRef)
	goToState("Waiting")
endFunction