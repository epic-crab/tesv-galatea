;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname GLTQF001 Extends Quest Hidden

;BEGIN ALIAS PROPERTY MageHenge
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MageHenge Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ContinueMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ContinueMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ThiefHenge
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ThiefHenge Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StartingLoc
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_StartingLoc Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StartingGearDump
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StartingGearDump Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ClassShrine
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ClassShrine Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY WarriorHenge
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WarriorHenge Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BlackPortaMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BlackPortaMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StartingGold
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StartingGold Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT HowToLeaveFragment
Function HowToLeaveFragment()
;BEGIN CODE
; stage 5
If(IsObjectiveDisplayed(3))
	SetObjectiveDisplayed(3, false)
EndIf
If(IsObjectiveDisplayed(4))
	SetObjectiveDisplayed(4, false)
EndIf
SetObjectiveDisplayed(5, abForce = true)
SetObjectiveDisplayed(6)
CharacterCreation.updateQuestMarkers()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT UpdateLeaveFragment
Function UpdateLeaveFragment()
;BEGIN CODE
; stage 6, 7, 8, 9
CharacterCreation.updateQuestMarkers()
int stage = getStage()
if(stage == 7)
SetObjectiveDisplayed(7)
elseif(stage > 7)
SetObjectiveDisplayed(7, false)
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT SkillsHideFragment
Function SkillsHideFragment()
;BEGIN CODE
; stage 4
SetObjectiveDisplayed(4, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT BackgroundIslandFragment
Function BackgroundIslandFragment()
;BEGIN CODE
; stage 10
CharacterCreation.startTowerMovement()
;emit the default background
int handle = ModEvent.create("GLT_LocationSelect")
if(handle)
	ModEvent.pushForm(handle, CharacterCreation.SelectedBackground)
	bool sent = ModEvent.send(handle)
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT UnlockActivatorsFragment
Function UnlockActivatorsFragment()
;BEGIN CODE
; stage 2
; now that player's starting skills have been determined, race menu can be reactivated and skills can be changed
ChargenTrigger.enable()
ClassTrigger.enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT StartUpFragment
Function StartUpFragment()
;BEGIN CODE
; stage 0
game.PrecacheCharGen()
ChargenTrigger.disable()
ClassTrigger.disable()
CharacterCreation.startDisintegrate()
startingUnderwater = GLT_UnderwaterStart.GetValue() == 1.0
Game.FadeOutGame(False, true, 0.5, 1.0)
if(startingUnderwater)
CharacterCreation.prepUnderwaterStart()
else
SetStage(1)
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT SkillsHelpFragment
Function SkillsHelpFragment()
;BEGIN CODE
; stage 3
SetObjectiveDisplayed(3)
SetObjectiveDisplayed(4)
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT RaceSkillsFragment
Function RaceSkillsFragment()
;BEGIN CODE
; stage 1
if(startingUnderwater)
WaterCollision.enable()
Utility.wait(1.0)
endIf
game.ShowRaceMenu()
utility.Wait(0.1)
SetObjectiveDisplayed(1)
FirstBridgeTrigger.goToState("active")
Game.EnablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = true, abLooking = true, abSneaking = true, abMenu = true, abJournalTabs = true)
ChargenAlias.forceRefTo(CharacterCreation.PlayerRef)
ChargenAlias.OldRace = CharacterCreation.PlayerRef.getRace()
ChargenAlias.CurrentRace = CharacterCreation.PlayerRef.getRace()
; work out the player's starting skills
CharacterCreation.handleStartingSkills()
; start background spawning
CharacterCreation.spawnBackgrounds()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT StartGameFragment
Function StartGameFragment()
;BEGIN CODE
; stage 15
Game.DisablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = true, abLooking = false, abSneaking = true, abMenu = true, abActivate = true)
FadeToBlackImod.apply()
Utility.wait(3.0)
FadeToBlackImod.PopTo(FadeToBlackHoldImod)
Actor PlayerRef = CharacterCreation.PlayerRef
int goldCount = PlayerRef.getItemCount(Gold001)
PlayerRef.removeItem(Gold001, goldCount);
TemporaryHoldingContainer.addItem(GoldPurse, goldCount/10)
if(PlayerRef.isEquipped(Rags))
	Rags.replace(PlayerRef, EquipItemsContainer)
else
	PlayerRef.removeItem(Rags, abSilent = true)
endIf
int items = PlayerRef.getNumItems()
while items > 0
	items -= 1
	Form f = PlayerRef.getNthForm(items)
	GLT_Replaceable replaceable = f as GLT_Replaceable
	if(replaceable && PlayerRef.isEquipped(f))
		replaceable.replace(PlayerRef, EquipItemsContainer)
	elseif(replaceable)
		replaceable.replace(PlayerRef, TemporaryHoldingContainer)
	elseif(f as Potion)
		replaceable = ((f as Potion).getNthEffectMagicEffect(0) as Form) as GLT_Replaceable_MagicEffect
		replaceable.replace(PlayerRef, TemporaryHoldingContainer)
	endIf
endWhile
CharacterCreation.restoreSkillBoosts()
setStage(16) ; 16 is an empty stage to signal that replaceables are done
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GLTQ01 Property CharacterCreation Auto
GlobalVariable Property GLT_UnderwaterStart Auto
ObjectReference Property WaterCollision Auto
ObjectReference Property ChargenTrigger Auto
ObjectReference Property ClassTrigger Auto
ObjectReference Property FirstBridgeTrigger Auto
ObjectReference Property TemporaryHoldingContainer Auto
ObjectReference Property EquipItemsContainer Auto
GLT_ChargenPlayerAlias Property ChargenAlias Auto
bool startingUnderwater
ImageSpaceModifier Property FadeToBlackImod Auto
ImageSpaceModifier Property FadeToBlackHoldImod Auto
ImageSpaceModifier Property FadeToBlackBackImod Auto
MiscObject Property Gold001 Auto
LeveledItem Property GoldPurse Auto
GLT_Replaceable Property Rags Auto