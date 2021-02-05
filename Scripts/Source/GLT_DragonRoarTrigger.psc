Scriptname GLT_DragonRoarTrigger extends HelgenRandomSoundScript

Quest Property GLT101 Auto
bool property intense auto

Event OnUpdate()
	if(intense)
		goToState("done")
		int myTimer = Utility.RandomInt(minTimer, maxTimer)
		int myOrigin = Utility.RandomInt(1,3)
		ObjectReference source = mySoundOrigin01
		if(myOrigin == 2)
			source = mySoundOrigin02
		elseif(myOrigin == 3)
			source = mySoundOrigin03
		endIf
		mySound01.play(source)
		source.knockAreaEffect(1,2048)
		game.shakeCamera(NONE, fCameraShake01)
		game.shakeController(fLIntensity01, fRIntensity01, fduration01)
	else
		parent.OnUpdate()
	endIf
	if(GLT101.getStage() < 10)
		GLT101.setStage(10)
	endIf
endEvent