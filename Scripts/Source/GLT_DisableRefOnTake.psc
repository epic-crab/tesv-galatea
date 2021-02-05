Scriptname GLT_DisableRefOnTake extends ObjectReference

ObjectReference Property Ref Auto
EffectShader Property Disintegrate Auto
Quest Property Chargen Auto

Event OnActivate(ObjectReference akActronaut)
	Disintegrate.play(Ref)
	Chargen.setObjectiveDisplayed(7, false)
	Utility.wait(1.5)
	Ref.disable()
endEvent