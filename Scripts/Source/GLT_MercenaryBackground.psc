;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname GLT_MercenaryBackground Extends GLT_BackgroundQuest

;BEGIN ALIAS PROPERTY LocationCenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LocationCenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StartingLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_StartingLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bounty
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bounty Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BountyLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_BountyLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Letter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Letter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Jarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jarl Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Steward
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Steward Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY InnLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_InnLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Alias_Hold.getLocation().setKeywordData(selfBounty.BQActiveQuest, 1)
ObjectReference ref = Alias_LocationCenterMarker.getReference()
Alias_Player.tryToMoveTo(ref)

transferStartingItems()
setStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Alias_Letter.TryToEnable()
Alias_Player.getReference().AddItem(Alias_Letter.GetReference())
SetObjectiveDisplayed(10)
Alias_MapMarker.GetReference().AddToMap()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveCompleted(10)

if Alias_Steward.GetReference()
	setObjectiveDisplayed(100)
else
	setObjectiveDisplayed(101)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
Alias_Hold.GetLocation().setKeywordData(selfBounty.BQActiveQuest, 0)
;Patch 1.9 #74354 changed to CompleteAllObjectives
CompleteAllObjectives()
selfBounty.RewardPlayer()
stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Keyword Property LocTypeHabitationHasInn Auto
BQScript Property selfBounty Auto

bool function filter(Location loc)
	return loc.hasKeyword(LocTypeHabitationHasInn)
endFunction