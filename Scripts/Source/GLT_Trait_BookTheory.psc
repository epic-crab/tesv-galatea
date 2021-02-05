Scriptname GLT_Trait_BookTheory extends ActiveMagicEffect

Location Property AbandonedPrison Auto

auto state waiting
	Event OnEffectStart(Actor akTarget, Actor akCaster)
		float baseHealth = akTarget.getBaseActorValue("Health")
		float baseStamina = akTarget.getBaseActorValue("Stamina")
		float baseMagicka = akTarget.getBaseActorValue("Magicka")
		akTarget.setActorValue("Health", baseHealth - 10.0)
		akTarget.setActorValue("Stamina", baseStamina - 20.0)
		akTarget.setActorValue("Magicka", baseMagicka - 20.0)
	endEvent
	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		float baseHealth = akTarget.getBaseActorValue("Health")
		float baseStamina = akTarget.getBaseActorValue("Stamina")
		float baseMagicka = akTarget.getBaseActorValue("Magicka")
		akTarget.setActorValue("Health", baseHealth + 10.0)
		akTarget.setActorValue("Stamina", baseStamina + 20.0)
		akTarget.setActorValue("Magicka", baseMagicka + 20.0)
	endEvent
	Event OnLocationChange(Location akOldLoc, Location akNewLoc)
		if(akNewLoc != AbandonedPrison)
			Game.AddPerkPoints(2)
			goToState("done")
		endIf
	endEvent
endState