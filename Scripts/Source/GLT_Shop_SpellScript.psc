Scriptname GLT_Shop_SpellScript extends ObjectReference  

Spell Property thisSpell Auto
MiscObject Property thisMisc Auto
Actor Property PlayerRef Auto
Weapon Property Unarmed Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	PlayerRef.addSpell(thisSpell, false)
	PlayerRef.RemoveItem(thisMisc, 1, true)
	if(!HasEquipped())
		PlayerRef.EquipSpell(thisSpell, 1)
	elseif(!HasEquipped(true))
		PlayerRef.EquipSpell(thisSpell, 0)
	endIf
endEvent

bool function HasEquipped(bool left = false)
	Form f = PlayerRef.getEquippedObject(1 - (left as int))
	return (f && f != Unarmed)
endFunction