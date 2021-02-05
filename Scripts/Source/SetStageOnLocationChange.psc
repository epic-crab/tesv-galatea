Scriptname SetStageOnLocationChange extends ReferenceAlias  

LocationAlias property targetLoc auto
int property stageToSet auto

Event OnLocationChange(Location oldLoc, Location newLoc)
	if(newLoc.isSameLocation(targetLoc.getLocation()))
		if(getOwningQuest().getStage() < stageToSet)
			getOwningQuest().setStage(stageToSet)
		endIf
	endIf
endEvent