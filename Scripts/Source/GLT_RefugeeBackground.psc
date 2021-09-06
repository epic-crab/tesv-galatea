;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname GLT_RefugeeBackground extends GLT_BackgroundQuest

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Brynjolf
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Brynjolf Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Kodlak
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Kodlak Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Astrid
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Astrid Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Faralda
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Faralda Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StartingLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_StartingLocation Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
ObjectReference ref = getStartMarker(Alias_StartingLocation.getLocation())
Alias_StartMarker.forceRefTo(ref)
Alias_Player.tryToMoveTo(ref)
GLTQ01_CharacterCreatorQuest.GLTQ001_FactionMonitors.registerFactionCallbackStages(self, 11, 21, 12, 22, 13, 23, 14, 24)
transferStartingItems()

setStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
;astrid talks about DB
setObjectiveDisplayed(14)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
;Brynjolf explains about TG
SetObjectiveDisplayed(12)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
;player joins cow
SetObjectiveDisplayed(11, false)
SetObjectiveDisplayed(12, false)
SetObjectiveDisplayed(14, false)
SetObjectiveCompleted(13)
SetObjectiveCompleted(10)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
;player joins DB
SetObjectiveDisplayed(11, false)
SetObjectiveDisplayed(12, false)
SetObjectiveDisplayed(13, false)
SetObjectiveCompleted(14)
SetObjectiveCompleted(10)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
;player joins TG
SetObjectiveDisplayed(11, false)
SetObjectiveDisplayed(13, false)
SetObjectiveDisplayed(14, false)
SetObjectiveCompleted(12)
SetObjectiveCompleted(10)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
;player buys a house
SetObjectiveDisplayed(11, false)
SetObjectiveDisplayed(12, false)
SetObjectiveDisplayed(13, false)
SetObjectiveDisplayed(14, false)
SetObjectiveCompleted(10)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
;player joins companions
SetObjectiveDisplayed(12, false)
SetObjectiveDisplayed(13, false)
SetObjectiveDisplayed(14, false)
SetObjectiveCompleted(11)
SetObjectiveCompleted(10)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
;player hears about cow
SetObjectiveDisplayed(13)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
;player hears about companions
SetObjectiveDisplayed(11)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

;mountain passes
Location Property DunmethPass Auto
Location Property PalePass Auto
Location Property RefugeesRest Auto
Location Property TalosPass Auto
;docks
Location Property Dawnstar Auto
Location Property SolitudeDocks Auto
Location Property Windhelm Auto
;starting markers
ObjectReference Property DunmethPassMarker Auto
ObjectReference Property PalePassMarker Auto
ObjectReference Property RefugeesRestMarker Auto
ObjectReference Property TalosPassMarker Auto
ObjectReference Property DawnstarDocksMarker Auto
ObjectReference Property SolitudeDocksMarker Auto
ObjectReference Property WindhelmDocksMarker Auto

bool function filter(Location loc)
	return (loc == RefugeesRest || loc == TalosPass || loc == PalePass || loc == DunmethPass || \
			loc == SolitudeDocks || loc == Dawnstar || loc == Windhelm)
endFunction

ObjectReference function getStartMarker(Location loc)
	if(loc == RefugeesRest)
		return RefugeesRestMarker
	elseif(loc == TalosPass)
		return TalosPassMarker
	elseif(loc == PalePass)
		return PalePassMarker
	elseif(loc == DunmethPass)
		return DunmethPassMarker
	elseif(loc == SolitudeDocks)
		return SolitudeDocksMarker
	elseif(loc == Dawnstar)
		return DawnstarDocksMarker
	elseif(loc == Windhelm)
		return WindhelmDocksMarker
	endIf
	return None
endFunction