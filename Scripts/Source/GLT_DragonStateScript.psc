Scriptname GLT_DragonStateScript extends ObjectReference  

GlobalVariable Property IsDragonborn Auto
GlobalVariable Property DragonsExist Auto

ObjectReference Property DragonSkull Auto
ObjectReference Property HeadSword Auto
ObjectReference Property ElderScroll Auto
ObjectReference Property ExplosionMarker Auto

Explosion Property CoverUp Auto
Message Property DragonPrompt Auto

Event OnLoad()
	if(IsDragonborn.getValue() > 0.0)
		HeadSword.disable(false)
	elseif(DragonsExist.getValue() > 0.0)
		ElderScroll.disable(false)
	else
		DragonSkull.disable(false)
		HeadSword.disable(false)
		ElderScroll.disable(false)
	endIf
endEvent

Event OnActivate(ObjectReference actronaut)
	int choice = DragonPrompt.show()
	if(choice == 0)
		IsDragonborn.setValue(1.0)
		DragonsExist.setValue(1.0)
		updateVisuals(choice)
	elseif(choice == 1)
		IsDragonborn.setValue(0.0)
		DragonsExist.setValue(1.0)
		updateVisuals(choice)
	else
		IsDragonborn.setValue(0.0)
		DragonsExist.setValue(0.0)
		updateVisuals(choice)
	endIf
endEvent

function updateVisuals(int case)
	if(case == 0)
		ExplosionMarker.placeAtMe(CoverUp)
		DragonSkull.enableNoWait(false)
		HeadSword.disableNoWait(false)
		ElderScroll.enableNoWait(false)
	elseif(case == 1)
		ExplosionMarker.placeAtMe(CoverUp)
		DragonSkull.enableNoWait(false)
		HeadSword.enableNoWait(false)
		ElderScroll.disableNoWait(false)
	else
		ExplosionMarker.placeAtMe(CoverUp)
		DragonSkull.disableNoWait(false)
		HeadSword.disableNoWait(false)
		ElderScroll.disableNoWait(false)
	endIf
endFunction