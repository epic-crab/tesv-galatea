Scriptname GLT_MagicSkill_ProdigyScript extends activemagiceffect  

Spell Property Prodigy Auto
MiscObject Property SpellToken Auto
GLTQ01 Property CharGen Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if(akTarget.hasSpell(Prodigy))
		akTarget.addItem(SpellToken)
	endIf
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if(akTarget.hasSpell(Prodigy))
		int count = akTarget.getItemCount(SpellToken)
		if(count > 0)
			akTarget.removeItem(SpellToken)
		else
			CharGen.revokeFreeSpell(SpellToken, 1)
		endIf
	endIf
endEvent