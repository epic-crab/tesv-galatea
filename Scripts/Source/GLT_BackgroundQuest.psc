Scriptname GLT_BackgroundQuest extends Quest  

GLTQ01 Property GLTQ01_CharacterCreatorQuest Auto
bool property providesOwnEquip auto
ObjectReference basePoint
;phantom appearance
ActorBase property PhantomBase auto
Spell property PhantomVisuals auto
String property PhantomName auto
Outfit property PhantomOutfit auto
ObjectReference property PhantomIdleMarker auto
;selection
Message Property ConfirmSelection Auto

ReferenceAlias Property StartingGearDump Auto

function init()
	basePoint = GLTQ01_CharacterCreatorQuest.BackgroundBasePoint
	GLT_BackgroundActor Phantom =  basePoint.PlaceActorAtMe(PhantomBase) as GLT_BackgroundActor
	Phantom.background = self
	Phantom.SetDisplayName(PhantomName)
	Phantom.SetOutfit(PhantomOutfit)
	if(!Phantom.hasSpell(PhantomVisuals))
		Phantom.addSpell(PhantomVisuals)
	endIf
	if(PhantomIdleMarker)
		Phantom.moveTo(PhantomIdleMarker)
	endIf
	Phantom.Disintegrate = GLTQ01_CharacterCreatorQuest.Disintegrate
	Phantom.UnDisintegrate = GLTQ01_CharacterCreatorQuest.UnDisintegrate
endFunction

function select()
	int choice = ConfirmSelection.show()
	if(choice == 0)
		GLTQ01_CharacterCreatorQuest.SelectedBackground = self
		int handle = ModEvent.create("GLT_LocationSelect")
		if(handle)
			ModEvent.pushForm(handle, self)
			bool sent = ModEvent.send(handle)
		endIf
	endIf
endFunction

bool function filter(Location loc)
	return false
endFunction