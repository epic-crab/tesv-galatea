Scriptname GLT_Disappearable extends ObjectReference  
EffectShader Property GLT_Disintegrate01FXS Auto

auto state dormant
endState

state vanished
	Event OnBeginState()
		GLT_Disintegrate01FXS.play(self)
		Utility.wait(1.5)
		disable()
		GLT_Disintegrate01FXS.stop(self)
	endEvent
	function disappear()
	endFunction
endState

function disappear()
	goToState("vanished")
endFunction