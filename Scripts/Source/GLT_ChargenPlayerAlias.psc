Scriptname GLT_ChargenPlayerAlias extends ReferenceAlias  

Actor Property PlayerRef Auto
Race property OldRace auto
Race property CurrentRace auto
bool spentStartingSpell
FormList Property FreeSpells Auto

GLTQ01 Property q Auto

bool hasAlterationToken
bool hasConjurationToken
bool hasDestructionToken
bool hasIllusionToken
bool hasRestorationToken
MiscObject Property AlterationToken Auto
MiscObject Property ConjurationToken Auto
MiscObject Property DestructionToken Auto
MiscObject Property IllusionToken Auto
MiscObject Property RestorationToken Auto

Event OnRaceSwitchComplete()
	int baseSkill = Game.GetGameSettingInt("iAVDSkillStart")
	OldRace = CurrentRace
	CurrentRace = PlayerRef.getRace()
	if(q.getStage() >= 2)
		int i = 0
		while i < 18
			PlayerRef.setActorValue(q.skills[i], baseSkill)
			i += 1
		endWhile
		; starting spells
		i = q.StartingSpell_Races.find(OldRace)
		if(i > 0)
			int count = PlayerRef.getItemCount(q.StartingSpell_Miscs[i])
			if(count > 0)
				PlayerRef.removeItem(q.StartingSpell_Miscs[i])
			else
				revokeFreeSpell(q.StartingSpell_Miscs[i])
			endIf
		endIf
		i = q.StartingSpell_Races.find(CurrentRace)
		if(i > 0)
			PlayerRef.addItem(q.StartingSpell_Miscs[i])
		endIf
		; speed mult fix
		PlayerRef.setActorValue("WeaponSpeedMult", 1.0)
		PlayerRef.setActorValue("LeftWeaponSpeedMult", 1.0)
	endIf
endEvent

function checkSpellTokens()
	hasAlterationToken = PlayerRef.getItemCount(AlterationToken) > 0
	hasConjurationToken = PlayerRef.getItemCount(ConjurationToken) > 0
	hasDestructionToken = PlayerRef.getItemCount(DestructionToken) > 0
	hasIllusionToken = PlayerRef.getItemCount(IllusionToken) > 0
	hasRestorationToken = PlayerRef.getItemCount(RestorationToken) > 0
endFunction
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if(akBaseItem as GLT_Shop_SpellScript)
		Spell s = (akBaseItem as GLT_Shop_SpellScript).thisSpell
		String skill = s.getNthEffectMagicEffect(s.getCostliestEffectIndex()).GetAssociatedSkill()
		if(skill == "Alteration" && hasAlterationToken)
			FreeSpells.addForm(s)
			hasAlterationToken = PlayerRef.getItemCount(AlterationToken) > 0
		elseif(skill == "Conjuration" && hasConjurationToken)
			FreeSpells.addForm(s)
			hasConjurationToken = PlayerRef.getItemCount(ConjurationToken) > 0
		elseif(skill == "Destruction" && hasDestructionToken)
			FreeSpells.addForm(s)
			hasDestructionToken = PlayerRef.getItemCount(DestructionToken) > 0
		elseif(skill == "Illusion" && hasIllusionToken)
			FreeSpells.addForm(s)
			hasIllusionToken = PlayerRef.getItemCount(IllusionToken) > 0
		elseif(skill == "Restoration" && hasRestorationToken)
			FreeSpells.addForm(s)
			hasRestorationToken = PlayerRef.getItemCount(RestorationToken) > 0
		endIf
	endIf
endEvent
function revokeFreeSpell(MiscObject SpellToken)
	String skillToMatch = "Alteration"
	if(SpellToken == ConjurationToken)
		skillToMatch = "Conjuration"
	elseif(SpellToken == DestructionToken)
		skillToMatch = "Destruction"
	elseif(SpellToken == IllusionToken)
		skillToMatch = "Illusion"
	elseif(SpellToken == RestorationToken)
		skillToMatch = "Restoration"
	endIf
	int count = FreeSpells.getSize()
	int i = 0
	while i < count
		Spell s = FreeSpells.getAt(i) as Spell
		if(skillToMatch == s.getNthEffectMagicEffect(s.getCostliestEffectIndex()).GetAssociatedSkill())
			PlayerRef.removeSpell(s)
			return
		endIf
		i += 1
	endWhile
endFunction