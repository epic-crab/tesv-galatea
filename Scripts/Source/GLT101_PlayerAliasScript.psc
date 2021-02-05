Scriptname GLT101_PlayerAliasScript extends ReferenceAlias  

Location property Helgen auto
Location property Dragonsreach auto
Quest Property MQ102 Auto

Actor selfRef
Quest q

Event OnInit()
	selfRef = getReference() as Actor
	q = getOwningQuest()
endEvent

state LmaoConcussions
	Event OnLocationChange(Location akOldLoc, Location akNewLoc)
		if(!akNewLoc.isSameLocation(Helgen))
			q.setStage(25)
		endIf
	endEvent
endState

state ListeningForWhiterun
	Event OnLocationChange(Location akOldLoc, Location akNewLoc)
		if(akNewLoc == Dragonsreach)
			registerForSingleUpdate(1.0)
		endIf
	endEvent
	Event OnUpdate()
		if(selfRef.getCurrentLocation() == Dragonsreach)
			if(MQ102.getStage() >= 100)
				q.setStage(100)
				unregisterForUpdate()
				return
			endIf
			registerForSingleUpdate(1.0)
		endIf
	endEvent
endState

Event OnDeath(Actor akKiller)
	if(q.isObjectiveDisplayed(20) && !q.isObjectiveCompleted(20))
		q.setObjectiveFailed(20)
	endIf
endEvent