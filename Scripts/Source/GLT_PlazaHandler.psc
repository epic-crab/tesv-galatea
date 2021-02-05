Scriptname GLT_PlazaHandler extends ObjectReference  

EffectShader Property Disintegrate Auto
EffectShader Property UnDisintegrate Auto
Actor Property PlayerRef Auto

GLT_RecoveryScript Property RecoveryTrigger Auto
ObjectReference Property RecoveryPoint Auto

ObjectReference Property PlazaRef Auto
ObjectReference Property WellRef Auto
ObjectReference Property ArmorStand Auto
ObjectReference Property FirePit Auto
ObjectReference Property Spit Auto
ObjectReference Property WellEnableParent Auto
GLT_FloatingClutterScript[] Property MarketItems auto
GLT_Disappearable[] Property ArmorBusts Auto
ObjectReference Property HealthPotion Auto
ObjectReference Property StaminaPotion Auto
ObjectReference Property MagickaPotion Auto
ObjectReference Property Poison Auto
ObjectReference Property FalmerBlood Auto
ObjectReference Property SkillPotion Auto
ObjectReference Property CarryPotion Auto
bool locked
float property undisintegrateTime = 2.1 autoreadonly

Event OnLoad()
	Disintegrate.play(PlazaRef)
	Disintegrate.play(WellRef)
	WellRef.setPosition(WellRef.X, WellRef.Y, WellRef.Z - 2048.0)
	Disintegrate.play(ArmorStand)
	Disintegrate.play(FirePit)
	Disintegrate.play(Spit)
	int i = 0
	while i < ArmorBusts.length
		Disintegrate.play(ArmorBusts[i])
		i += 1
	endWhile
	Disintegrate.play(HealthPotion)
	Disintegrate.play(StaminaPotion)
	Disintegrate.play(MagickaPotion)
	Disintegrate.play(Poison)
	Disintegrate.play(FalmerBlood)
	Disintegrate.play(SkillPotion)
	Disintegrate.play(CarryPotion)
	locked = false
endEvent

state active
	Event OnTriggerLeave(ObjectReference akActionRef)
		if(akActionRef == PlayerRef && !locked);disabled for now due to performance issues
			;goToState("dormant")
		endIf
	endEvent
	Event OnBeginState()
		locked = true
		UnDisintegrate.play(PlazaRef, undisintegrateTime)
		Disintegrate.stop(PlazaRef)
		UnDisintegrate.play(ArmorStand, undisintegrateTime)
		Disintegrate.stop(ArmorStand)
		UnDisintegrate.play(FirePit, undisintegrateTime)
		Disintegrate.stop(FirePit)
		UnDisintegrate.play(Spit, undisintegrateTime)
		Disintegrate.stop(Spit)
		WellEnableParent.enableNoWait()
		int i = 0
		while i < ArmorBusts.length
			if(ArmorBusts[i].getState() != "vanished")
				UnDisintegrate.play(ArmorBusts[i])
				Disintegrate.stop(ArmorBusts[i])
			endIf
			i += 1
		endWhile
		i = 0
		while i < MarketItems.length
			if(MarketItems[i].getState() != "vanished")
				MarketItems[i].goToState("inPosition")
			endIf
			i += 1
		endWhile
		UnDisintegrate.play(HealthPotion, undisintegrateTime)
		Disintegrate.stop(HealthPotion)
		UnDisintegrate.play(StaminaPotion, undisintegrateTime)
		Disintegrate.stop(StaminaPotion)
		UnDisintegrate.play(MagickaPotion, undisintegrateTime)
		Disintegrate.stop(MagickaPotion)
		UnDisintegrate.play(Poison, undisintegrateTime)
		Disintegrate.stop(Poison)
		UnDisintegrate.play(FalmerBlood, undisintegrateTime)
		Disintegrate.stop(FalmerBlood)
		UnDisintegrate.play(SkillPotion, undisintegrateTime)
		Disintegrate.stop(SkillPotion)
		UnDisintegrate.play(CarryPotion, undisintegrateTime)
		Disintegrate.stop(CarryPotion)
		utility.wait(MarketItems[i - 1].timeBack - 1.0)
		WellRef.setPosition(WellRef.X, WellRef.Y, WellRef.Z + 2048.0)
		UnDisintegrate.play(WellRef, undisintegrateTime)
		Disintegrate.stop(WellRef)
		locked = false
	endEvent
endState
auto state dormant
	Event OnTriggerEnter(ObjectReference akActionRef)
		if(akActionRef == PlayerRef)
			if(RecoveryPoint)
				RecoveryTrigger.LastRecoveryPoint = RecoveryPoint
			endIf
			if(!locked)
				goToState("active")
			endIf
		endIf
	endEvent
	Event OnBeginState()
		locked = true
		Disintegrate.play(WellRef)
		UnDisintegrate.stop(WellRef)
		WellRef.setPosition(WellRef.X, WellRef.Y, WellRef.Z - 2048.0)
		WellEnableParent.disableNoWait()
		int i = ArmorBusts.length
		while i > 0
			i -= 1
			if(ArmorBusts[i].getState() != "vanished")
				Disintegrate.play(ArmorBusts[i])
				UnDisintegrate.stop(ArmorBusts[i])
			endIf
		endWhile
		Disintegrate.play(HealthPotion)
		UnDisintegrate.stop(HealthPotion)
		Disintegrate.play(StaminaPotion)
		UnDisintegrate.stop(StaminaPotion)
		Disintegrate.play(MagickaPotion)
		UnDisintegrate.stop(MagickaPotion)
		Disintegrate.play(Poison)
		UnDisintegrate.stop(Poison)
		Disintegrate.play(FalmerBlood)
		UnDisintegrate.stop(FalmerBlood)
		Disintegrate.play(SkillPotion)
		UnDisintegrate.stop(SkillPotion)
		Disintegrate.play(CarryPotion)
		UnDisintegrate.stop(CarryPotion)
		i = MarketItems.length
		while i > 0
			i -= 1
			if(MarketItems[i].getState() != "vanished")
				MarketItems[i].goToState("floating")
			endIf
		endWhile
		Disintegrate.play(PlazaRef)
		UnDisintegrate.stop(PlazaRef)
		Disintegrate.play(ArmorStand)
		UnDisintegrate.stop(ArmorStand)
		Disintegrate.play(FirePit)
		UnDisintegrate.stop(FirePit)
		Disintegrate.play(Spit)
		UnDisintegrate.stop(Spit)
		locked = false
	endEvent
endState