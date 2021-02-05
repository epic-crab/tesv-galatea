Scriptname GLT_VanillaStartActivatorScript extends ObjectReference

GLTQ01 Property Chargen Auto
Actor Property PlayerRef Auto
GlobalVariable Property IsDragonborn Auto
Message Property HelgenDescription Auto
Message Property HelgenNoDragonborn Auto
ObjectReference Property CartFurniture Auto
ObjectReference Property CartFurnitureStartPoint Auto

Event OnActivate(ObjectReference actronaut)
	if(actronaut == PlayerRef)
		if(IsDragonborn.GetValue() == 0.0)
			HelgenNoDragonborn.show()
		else
			int choice = HelgenDescription.show()
			if(choice == 0)
				Game.DisablePlayerControls(abMovement = true, abCamSwitch = True, abLooking = false, abSneaking = false, abmenu = true, abactivate = True, abJournalTabs = True)
				CartFurniture.enable()
				PlayerRef.moveTo(CartFurnitureStartPoint)
				Game.forceThirdPerson()
				CartFurniture.activate(PlayerRef)
				Chargen.vanillaStartGame()
			endIf
		endIf
	endIf
endEvent