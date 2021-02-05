Scriptname GLT_ClassActivatorScript extends ObjectReference  

Actor Property PlayerRef Auto
GLTQ01 Property CharacterCreation Auto
ObjectReference Property KneelMarker Auto

Event OnActivate(ObjectReference ref)
	disableNoWait()
	KneelMarker.enable()
	PlayerRef.moveTo(KneelMarker, afZOffset = PlayerRef.getPositionZ() - KneelMarker.getPositionZ())
	Game.forceThirdPerson()
	PlayerRef.activate(KneelMarker, true)
	CharacterCreation.setObjectiveDisplayed(3, false)
	CharacterCreation.ShowClassMenu()
endEvent

function resetSelector()
	while(KneelMarker.isFurnitureInUse())
		Utility.wait(1.0)
	endWhile
	kneelMarker.disable()
	enableNoWait()
endFunction