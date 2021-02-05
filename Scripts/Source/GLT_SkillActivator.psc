Scriptname GLT_SkillActivator extends ObjectReference  

GLTQ01 Property CharacterCreation Auto
Message Property SkillSelect Auto
GlobalVariable Property FreeSkillPoints Auto
GlobalVariable Property MajorSkillBoost Auto
GlobalVariable Property MinorSkillBoost Auto
GlobalVariable Property MajorMinorDiff Auto
Spell Property MajorSkill Auto
Spell Property MinorSkill Auto

function select()
endFunction
function deselect()
endFunction

auto state dormant ; player does not have this skill
	Event OnActivate(ObjectReference ref)
		int choice = SkillSelect.show()
		if (choice == 0) ;major
			select()
			(ref as Actor).addSpell(MajorSkill)
			FreeSkillPoints.mod(-1.0*MajorSkillBoost.getValue())
			CharacterCreation.updateCurrentInstanceGlobal(FreeSkillPoints)
		elseif (choice == 3) ;minor
			select()
			(ref as Actor).addSpell(MinorSkill)
			FreeSkillPoints.mod(-1.0*MinorSkillBoost.getValue())
			CharacterCreation.updateCurrentInstanceGlobal(FreeSkillPoints)
		endIf
	endEvent
endState

state transitioning
endState

state active ; player already has this skill
	Event OnActivate(ObjectReference ref)
		Actor a = ref as Actor
		int choice = SkillSelect.show()
		if (choice == 1) ; major skill, upgrading from minor skill
			a.removeSpell(MinorSkill)
			a.addSpell(MajorSkill)
			FreeSkillPoints.mod(-1.0*MajorMinorDiff.getValue())
			CharacterCreation.updateCurrentInstanceGlobal(FreeSkillPoints)
		elseif (choice == 2) ; minor skill, downgrading from major skill
			a.removeSpell(MajorSkill)
			a.addSpell(MinorSkill)
			FreeSkillPoints.mod(MajorMinorDiff.getValue())
			CharacterCreation.updateCurrentInstanceGlobal(FreeSkillPoints)
		elseif (choice == 4) ; remove this skill
			deselect()
			if(a.hasSpell(MajorSkill)) ; case major
				a.removeSpell(MajorSkill)
				FreeSkillPoints.mod(MajorSkillBoost.getValue())
				CharacterCreation.updateCurrentInstanceGlobal(FreeSkillPoints)
			else ; case minor
				a.removeSpell(MinorSkill)
				FreeSkillPoints.mod(MinorSkillBoost.getValue())
				CharacterCreation.updateCurrentInstanceGlobal(FreeSkillPoints)
			endIf
		endIf
	endEvent
endState