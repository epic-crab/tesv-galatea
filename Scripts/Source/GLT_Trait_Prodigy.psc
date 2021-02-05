Scriptname GLT_Trait_Prodigy extends activemagiceffect

Spell[] Property MajorSkills Auto
MiscObject[] Property SpellTokens Auto
GLTQ01 Property CharGen Auto
ObjectReference Property SpellShop Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int i = 0
	while i < MajorSkills.length
		Spell skill = MajorSkills[i]
		if(akTarget.hasSpell(skill))
			akTarget.AddItem(SpellTokens[i])
		endIf
		i += 1
	endWhile
	;open spell shop menu
	Utility.wait(0.1)
	SpellShop.Activate(getTargetActor())
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	int i = 0
	while i < SpellTokens.length
		int count = akTarget.getItemCount(SpellTokens[i])
		if(count == 0 && akTarget.hasSpell(MajorSkills[i]))
			CharGen.revokeFreeSpell(SpellTokens[i], 1)
		elseif(count > 0 && akTarget.hasSpell(MajorSkills[i]))
			akTarget.removeItem(SpellTokens[i], 1)
		endIf
		i += 1
	endWhile	
endEvent