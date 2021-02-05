Scriptname GLT_LibraryGateScript extends ObjectReference  

GLT_LibraryController Property library Auto
EffectShader Property Disintegrate Auto

Event OnActivate(ObjectReference akActronaut)
	Disintegrate.play(self)
	library.appear()
	Utility.wait(1.0)
	disable()
endEvent