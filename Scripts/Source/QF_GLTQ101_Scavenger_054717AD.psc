;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname QF_GLTQ101_Scavenger_054717AD Extends Quest Hidden

;BEGIN ALIAS PROPERTY BanditSpawnPoint
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BanditSpawnPoint Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HelgenOrbitMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HelgenOrbitMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Gerdur
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Gerdur Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HelgenBandit3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HelgenBandit3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ExteriorRubbleMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ExteriorRubbleMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Riverwood
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Riverwood Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Mirmulnir
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Mirmulnir Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HelgenBandit1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HelgenBandit1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY KeepEnableMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_KeepEnableMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HelgenBandit2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HelgenBandit2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Alvor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Alvor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY RiverwoodMapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_RiverwoodMapMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveCompleted(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Alias_KeepEnableMarker.tryToEnable()
Alias_ExteriorRubbleMarker.tryToEnable()
MirmulnirHandler.goToHelgen()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
if(getStageDone(15) && !getStageDone(30))
SeverelyWoundedFF.cast(PlayerRef)
endIf
if(isObjectiveDisplayed(20) && !isObjectiveCompleted(20))
setObjectiveCompleted(20)
endIf
if(isObjectiveDisplayed(25) && !isObjectiveCompleted(25))
setObjectiveDisplayed(25, false)
endIf
if(isObjectiveDisplayed(30) && !isObjectiveCompleted(30))
setObjectiveCompleted(30)
endIf
if(isObjectiveDisplayed(35) && !isObjectiveCompleted(35))
setObjectiveCompleted(35)
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
MirmulnirHandler.stopCombatFlyToWhiterun()
MirmulnirHandler.goHomeWhenPlayerIsntLooking(5.0)
SetObjectiveDisplayed(25)
MQ102.start()
MQ102.RiverwoodMapMarker.AddToMap()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(10)
SetActive()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
defaultquestrespawnscript respawner = (self as quest) as defaultquestrespawnscript
;BEGIN CODE
setActive()
Sound.setInstanceVolume(DragonSound.play(Alias_KeepEnableMarker.getReference()), 0.8)
ImpactSound.play(Alias_KeepEnableMarker.getReference())
Alias_KeepEnableMarker.getReference().placeAtMe(Impact)
Game.DisablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = true, abLooking = false, abSneaking = false, abMenu = true, abActivate = true)
FadeToBlackImod.apply()
Utility.wait(3.0)
PlayerRef.forceRemoveRagdollFromWorld()
PlayerRef.moveTo(Alias_ExteriorRubbleMarker.getReference())
MirmulnirHandler.goToHelgen()
respawner.respawn(Alias_HelgenBandit1)
respawner.respawn(Alias_HelgenBandit2)
respawner.respawn(Alias_HelgenBandit3)
FadeToBlackImod.PopTo(FadeToBlackHoldImod)
Game.enablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = true, abLooking = true, abSneaking = true, abMenu = true, abActivate = true)
FadeToBlackHoldImod.PopTo(FadeToBlackBackImod)
FadeToBlackHoldImod.Remove()
SetObjectiveDisplayed(10, false)
SetObjectiveDisplayed(15)
PlayerAlias.goToState("LmaoConcussions")
RegisterForSingleLOSGain(PlayerRef, Alias_Mirmulnir.getReference())
Alias_KeepEnableMarker.tryToDisable()
TitleSequenceCount = 0
Game.showTitleSequenceMenu()
registerForSingleUpdate(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
(Alias_Mirmulnir as GLT101_MirmulnirAliasScript).registerForSingleLOSGain(Alias_Mirmulnir.getReference() as Actor, PlayerRef)
setObjectiveCompleted(15)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
;player has lost sight of Mirmulnir
setObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; player has warned someone about Mirmulnir
Game.AddAchievement(1)
if(!getStageDone(30))
SeverelyWoundedFF.cast(PlayerRef)
endIf
Alias_ExteriorRubbleMarker.tryToDisable()
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
if(isObjectiveDisplayed(30))
setObjectiveCompleted(30)
endIf
setObjectiveDisplayed(35)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
; make wound non-permanent
SeverelyWoundedFF.cast(PlayerRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
	setStage(16)
endEvent

int TitleSequenceCount
Event OnUpdate()
	If TitleSequenceCount == 0
		Game.StartTitleSequence("Sequence1")
		TitleSequenceCount = 1
		RegisterForSingleUpdate(5.0)
	ElseIf TitleSequenceCount == 1
		Game.StartTitleSequence("Sequence2")
		TitleSequenceCount = 2
		RegisterForSingleUpdate(5.0)
	ElseIf TitleSequenceCount == 2
; 		debug.trace(self + "Playing Title Card 3")
		Game.StartTitleSequence("Sequence3")
		TitleSequenceCount = 3
		RegisterForSingleUpdate(5.0)
	ElseIf TitleSequenceCount == 3
; 		debug.trace(self + "Playing Title Card 4")
		Game.StartTitleSequence("Sequence4")
		TitleSequenceCount = 4
		RegisterForSingleUpdate(10.0)
	ElseIf TitleSequenceCount == 4
		Game.HideTitleSequenceMenu()
	EndIf

EndEvent

Actor Property PlayerRef Auto
Explosion Property Impact Auto
Sound Property DragonSound Auto
Sound Property ImpactSound Auto
ImageSpaceModifier Property FadeToBlackImod Auto
ImageSpaceModifier Property FadeToBlackHoldImod Auto
ImageSpaceModifier Property FadeToBlackBackImod Auto
GLT101_PlayerAliasScript Property PlayerAlias Auto
QF_GLTQ003_MirmulnirHandler_0546C69B Property MirmulnirHandler Auto
QF_MQ102_0004E50D Property MQ102 Auto
Quest Property MQ102A Auto
Quest Property MQ102B Auto
Spell Property SeverelyWoundedFF Auto
