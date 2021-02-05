Scriptname GLT_CollisionDisc extends ObjectReference

Actor Property PlayerRef Auto
int stepCount

Event OnInit()
	stepCount = 0
	moveto(self, afZoffset = 8.0)
	registerForAnimationEvent(PlayerRef, "FootLeft")
	registerForAnimationEvent(PlayerRef, "FootRight")
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	stepCount += 1
	if(stepCount >= 4)
		Utility.wait(0.1)
		cleanup()
	endIf
endEvent

function cleanup()
	unregisterForAnimationEvent(PlayerRef, "FootLeft")
	unregisterForAnimationEvent(PlayerRef, "FootRight")
	disable()
	delete()
endFunction