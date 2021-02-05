Scriptname GLT_BlackPortalManager extends GLT_PortalManager  

GLT_PortalManager[] property pairedPortals auto

auto state dark
	function goLive()
		goToState("live")
		Portal1.playAnimation("playAnim02")
	endFunction
endState

state live
	Event OnBeginState()
		registerForSingleUpdate(5.0)
	endEvent
	Event OnUpdate()
		if(PlayerRef.getDistance(Portal1) > radius)
			int i = pairedPortals.length
			bool allDark = true
			while i > 0 && allDark
				i -= 1
				if(pairedPortals[i].getState() == "live")
					allDark = false
				endIf
			endWhile
			if(allDark && PlayerRef.getDistance(portal1) > 1800.0)
				Portal1.playAnimation("playAnim01")
				goToState("dark")
			else
				registerForSingleUpdate(1.0)
			endIf
		else
			registerForSingleUpdate(1.0)
		endIf
	endEvent
endState