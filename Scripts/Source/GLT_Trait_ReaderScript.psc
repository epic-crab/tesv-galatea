Scriptname GLT_Trait_ReaderScript extends ActiveMagicEffect

Spell Property PleasantDreams Auto
GlobalVariable Property IsWerewolf Auto

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if(akBaseObject as Book)
		RegisterForSleep()
		RegisterForSingleUpdateGameTime(1.0)
	endIf
endEvent
Event OnUpdateGameTime()
	UnregisterForSleep()
endEvent

Event OnSleepStop(bool abInterrupted)
	if(IsWerewolf.getValue() == 0.0)
		getTargetActor().addSpell(PleasantDreams)
	endIf
endEvent