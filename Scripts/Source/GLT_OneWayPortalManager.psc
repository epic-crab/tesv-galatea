Scriptname GLT_OneWayPortalManager extends GLT_PortalManager  

state live
	Event OnUpdate()
		if(PlayerRef.getDistance(Portal1) > radius)
			goToState("dark")
			Portal1.playAnimation("playAnim01")
			if(!blackPortal)
				Utility.wait(1.0)
				Portal2.playAnimation("playAnim01")
			endIf
		else
			registerForSingleUpdate(0.1)
		endIf
	endEvent
endState