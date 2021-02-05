Scriptname GLT_MothSpawner extends critterspawn

Activator Property GalateaMoth Auto
; Do initial stuff when my 3D has loaded up.
EVENT OnCellAttach()
	registerForSingleUpdate(6.0)
endEVENT
EVENT onUnload()
	unregisterForUpdate()
endEVENT
EVENT onCellDetach()
	unregisterForUpdate()
endEVENT
Event OnUpdate()
	if(shouldSpawn())
		SpawnInitialCritterBatch()
	endIf
	registerForSingleUpdate(6.0)
endEVENT

; Spawns one Critter
bool Function SpawnCritter()
	if (iCurrentCritterCount < iMaxCritterCount) && (iCurrentCritterCount >= 0)
		; Go ahead with the actual spawn
		return SpawnCritterAtRef(self)
	elseif iCurrentCritterCount < 0
		unregisterForUpdate()
	endif
	return False
endFunction

bool Function SpawnCritterAtRef(ObjectReference arSpawnRef)
	; Create the critter and cast it to the critter base class
	ObjectReference critterRef = arSpawnRef.PlaceAtMe(GalateaMoth, 1, false, true)
	Critter thecritter = critterRef as Critter
	if thecritter == none
		return false
	endif
	; Set initial variables on the critter
	thecritter.SetInitialSpawnerProperties(fLeashLength, fLeashHeight, fLeashDepth, fMaxPlayerDistance + fLeashLength, self)
	iCurrentCritterCount += 1
	return true
endFunction

; Utility method that tells the spawner whether it should spawn critters
bool Function ShouldSpawn()
	if self.GetParentCell() && self.is3dLoaded()
		return (GetPlayerDistance() <= fMaxPlayerDistance)
	else		;if the 3d is not loaded jump out of the looped state. Just an extra safety measure.
		unregisterForUpdate()
		return false
	endif
endFunction
