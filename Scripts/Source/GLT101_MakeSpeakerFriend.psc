;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname GLT101_MakeSpeakerFriend Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
function Fragment_0(ObjectReference akSpeakerRef)
;BEGIN CODE
MQ102RiverwoodFriend.forceRefTo(akSpeakerRef)
getOwningQuest().setObjectiveDisplayed(25, false)
MQ102RiverwoodFriend.getOwningQuest().setObjectiveCompleted(10)
;END CODE
endFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
function Fragment_1(ObjectReference akSpeakerRef)
;BEGIN CODE
getOwningQuest().setStage(26)
getOwningQuest().setStage(100)
MQ102RiverwoodFriend.getOwningQuest().setStage(30)
MQ102RiverwoodFriend.getOwningQuest().setStage(50)
;END CODE
endFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property MQ102RiverwoodFriend Auto
