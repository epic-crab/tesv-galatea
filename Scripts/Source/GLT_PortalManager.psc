Scriptname GLT_PortalManager extends ObjectReference

bool property blackPortal auto
GLT_BlackPortalManager property blackPortalManager auto
Actor Property PlayerRef Auto
ObjectReference Property Portal1 Auto
ObjectReference Property Portal2 Auto
float property radius auto

function goLive()
endFunction

auto state dark
	function goLive()
		goToState("live")
		Portal1.playAnimation("playAnim02")
		if(blackPortal)
			blackPortalManager.goLive()
		else
			Portal2.playAnimation("playAnim02")
		endIf
	endFunction
endState

state live
	Event OnBeginState()
		registerForSingleUpdate(0.1)
	endEvent
	Event OnUpdate()
		if(PlayerRef.getDistance(Portal1) > radius && (!Portal2 || PlayerRef.getDistance(Portal2) > radius))
			goToState("dark")
			Portal1.playAnimation("playAnim01")
			if(!blackPortal)
				Portal2.playAnimation("playAnim01")
			endIf
		else
			registerForSingleUpdate(0.1)
		endIf
	endEvent
endState