Scriptname GLT_RacemenuTriggerScript extends ObjectReference

ObjectReference Property Marker Auto

Event OnActivate(ObjectReference ref)
	ref.moveTo(marker)
	Game.showRacemenu()
endEvent