Scriptname GLT_Trait_DrunkardMain extends ActiveMagicEffect

FormList Property AlcoholicDrinks Auto
Spell Property DrunkardSideEffects Auto

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if(AlcoholicDrinks.hasForm(akBaseObject))
		Actor t = getTargetActor()
		if(t.hasSpell(DrunkardSideEffects))
			t.removeSpell(DrunkardSideEffects)
		endIf
		registerForSingleUpdateGameTime(18.0)
	endIf
endEvent

Event OnUpdateGameTime()
	Actor t = getTargetActor()
	t.addSpell(DrunkardSideEffects)
endEvent