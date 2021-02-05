Scriptname GLT_FloatingClutterScript extends ObjectReference

int property originalMotionType = 4 auto

float property timeToPosition = 0.8 auto
float property timeBack = 0.8 auto
float speedToPosition
float speedBack
ObjectReference property originalRef auto
ObjectReference property targetRef auto
ObjectReference property otherEnabler auto
Sound property thunk auto
float property thunkVolume = 1.0 auto

auto state inPosition
	Event OnLoad()
		while !(Is3DLoaded())
			Utility.wait(1.5)
		endWhile
		speedToPosition = targetRef.getDistance(originalRef)/timeToPosition
		speedBack = speedToPosition*timeToPosition/timeBack
		goToState("floating")
	endEvent
	Event OnBeginState()
		stopTranslation()
		TranslateToRef(originalRef, speedToPosition)
	endEvent
	Event OnTranslationComplete()
		setMotionType(originalMotionType)
		if(thunk)
			int thunkID = thunk.play(self)
			Sound.setInstanceVolume(thunkID, thunkVolume)
		endIf
		otherEnabler.enable()
	endEvent
endState

state floating
	Event OnBeginState()
		otherEnabler.disable()
		setMotionType(Motion_Keyframed)
		TranslateToRef(targetRef, speedBack)
	endEvent
endState