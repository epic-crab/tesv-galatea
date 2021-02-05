Scriptname GLT_DragonIslandTriggerboxScript extends ObjectReference  

Actor Property PlayerRef Auto
bool property playerInMothFlockRange auto
GLT_MothSpawner[] Property MothDoodads Auto
ObjectReference Property GlowSpot Auto

Event OnTriggerEnter(ObjectReference akActionRef)
	if(akActionRef == PlayerRef)
		GlowSpot.enableNoWait()
		int i = 0
		while i < MothDoodads.length
			MothDoodads[i].registerForSingleUpdate(0.1)
			i += 1
		endWhile
		playerInMothFlockRange = true
	endIf
endEvent

Event OnTriggerLeave(ObjectReference akActionRef)
	if(akActionRef == PlayerRef)
		GlowSpot.disableNoWait()
		playerInMothFlockRange = false
	endIf
endEvent