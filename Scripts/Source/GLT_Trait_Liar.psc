Scriptname GLT_Trait_Liar extends activemagiceffect  

GlobalVariable Property CrimePettyCrimeThreshold Auto
float property mult auto
float originalValue

Event OnEffectStart(Actor akTarget, Actor akCaster)
	originalValue = CrimePettyCrimeThreshold.getValue()
	CrimePettyCrimeThreshold.setValue(CrimePettyCrimeThreshold.getValue() * mult)
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	CrimePettyCrimeThreshold.setValue(originalValue)
endEvent