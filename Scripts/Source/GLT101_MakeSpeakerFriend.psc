;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname GLT101_MakeSpeakerFriend Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
MQ102RiverwoodFriend.forceRefTo(akSpeaker)
MQ102RiverwoodFriend.getOwningQuest().setStage(30)
getOwningQuest().setObjectiveCompleted(25)
getOwningQuest().setObjectiveDisplayed(30, false)
getOwningQuest().setStage(100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property MQ102RiverwoodFriend Auto
