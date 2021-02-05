;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_GLTBG_WandererBackgroundQ_052FACAF Extends Quest Hidden

;BEGIN ALIAS PROPERTY MapMarkerForStart
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarkerForStart Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StartingLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_StartingLocation Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
ObjectReference ref = Alias_MapMarkerForStart.getReference()
ref.addToMap(true)
if(ref.getLinkedRef())
ref = ref.getLinkedRef()
endIf
Game.getPlayer().moveTo(ref)

((self as Quest) as GLT_BackgroundQuest).GLTQ01_CharacterCreatorQuest.Fragments.TemporaryHoldingContainer.removeAllItems(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
