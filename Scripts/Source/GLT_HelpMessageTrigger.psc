Scriptname GLT_HelpMessageTrigger extends ObjectReference  

Actor Property PlayerRef Auto
Quest Property CharacterCreation Auto
int property stageToSet = -1 Auto
Message[] Property HelpMessages Auto
String Property HelpEventName Auto
float property messageDuration = 3.0 auto
float property messageInterval = 0.5 auto
GlobalVariable Property ShowTutorials Auto
int property fadeOutStage auto

GLT_RecoveryScript Property RecoveryTrigger Auto
ObjectReference Property RecoveryPoint Auto

auto state dormant
	Event OnTriggerEnter(ObjectReference ref)
		if(ref == PlayerRef)
			if(CharacterCreation.getStage() < stageToSet)
				CharacterCreation.setStage(stageToSet)
			endIf
			if(RecoveryPoint)
				RecoveryTrigger.LastRecoveryPoint = RecoveryPoint
			endIf
			int i = 0
			bool show = ShowTutorials.getValue() > 0.0
			int currentStage = CharacterCreation.getStage()
			bool stage = (stageToSet >= 0 && currentStage == stageToSet) || (stageToSet < 0 && currentStage < fadeOutStage)
			while i < HelpMessages.length && (CharacterCreation.getStage() < fadeOutStage) && show
				HelpMessages[i].ShowAsHelpMessage(HelpEventName + i, messageDuration, 1.0, 1)
				Utility.wait(messageDuration + messageInterval + 0.1)
				currentStage = CharacterCreation.getStage()
				stage = (stageToSet >= 0 && currentStage == stageToSet) || (stageToSet < 0 && currentStage < fadeOutStage)
				i += 1
			endWhile
			goToState("done")
		endIf
	endEvent
endState

Event OnTriggerEnter(ObjectReference akActionRef)
	if(akActionRef == PlayerRef)
		if(RecoveryPoint)
			RecoveryTrigger.LastRecoveryPoint = RecoveryPoint
		endIf
	endIf
endEvent