Scriptname GLT_Shop_ItemScript extends ObjectReference

Actor Property PlayerRef Auto
Armor Property Rags Auto
EquipSlot Property BothHands Auto
Weapon Property Unarmed Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if(akNewContainer == PlayerRef)
		addToPlayer()
	endIf
endEvent

function replaceRags(Armor newArmor)
	if(PlayerRef.isEquipped(Rags))
		PlayerRef.equipItem(newArmor)
		PlayerRef.removeItem(Rags, 1, true)
	endIf
endFunction

function addToPlayer()
	;no-op
endFunction

bool function HasEquipped(bool left = false)
	Form f = PlayerRef.getEquippedObject(1 - (left as int))
	return (f && f != Unarmed)
endFunction

function equipNewItem(Form newItem)
	bool rightFree = !HasEquipped()
	bool leftFree = !HasEquipped(true)
	Weapon newWeapon = newItem as Weapon
	Armor newShield = newItem as Armor
	Spell newSpell = newItem as Spell
	if(newWeapon)
		if(newWeapon.getEquipType() == BothHands && rightFree && leftFree) ; 2H weapon or bow
			PlayerRef.EquipItem(newWeapon)
		else ; 1H weapon
			if(!HasEquipped())
				PlayerRef.EquipItem(newWeapon)
			elseif(!HasEquipped(true))
				PlayerRef.EquipItemEx(newWeapon, 2)
			endIf
		endIf
	elseif(newShield)
		if(leftFree)
			PlayerRef.EquipItem(newShield)
		endIf
	elseif(newSpell)
		if(rightFree)
			PlayerRef.EquipSpell(newSpell, 1)
		elseif(leftFree)
			PlayerRef.EquipSpell(newSpell, 0)
		endIf
	endIf
endFunction