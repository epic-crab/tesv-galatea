Scriptname GLT_Shop_WeaponScript extends ObjectReference  

GLT_Disappearable Property Display Auto
Weapon Property ThisWeapon Auto
Armor Property ThisShield Auto
Weapon Property Unarmed Auto
Actor Property PlayerRef Auto
GLT_WeaponShopScript property shop auto
EquipSlot Property BothHands Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if(ThisWeapon)
		if(ThisWeapon.getEquipType() == BothHands && !HasEquipped() && !HasEquipped(true)) ; 2H weapon or bow
			PlayerRef.EquipItem(ThisWeapon)
		else ; 1H weapon
			if(!HasEquipped())
				PlayerRef.EquipItem(ThisWeapon)
			elseif(!HasEquipped(true))
				PlayerRef.EquipItemEx(ThisWeapon, 2)
			endIf
		endIf
		if(ThisWeapon.IsBattleAxe())
			shop.BattleaxeAxeMade = true
		elseif(ThisWeapon.IsBow())
			shop.BowMade = true
		elseif(ThisWeapon.IsDagger())
			shop.DaggerMade = true
		elseif(ThisWeapon.IsGreatsword())
			shop.GreatSwordMade = true
		elseif(ThisWeapon.IsMace())
			shop.MaceMade = true
		elseif(ThisWeapon.IsSword())
			shop.SwordMade = true
		elseif(ThisWeapon.IsWarhammer())
			shop.WarhammerMade = true
		elseif(ThisWeapon.IsWarAxe())
			shop.WarAxeMade = true
		else
			shop.StaffMade = true
		endIf
	else
		if(!HasEquipped(true))
			PlayerRef.EquipItem(ThisShield)
		endIf
		shop.ShieldMade = true
	endIf
	Display.goToState("vanished")
endEvent

bool function HasEquipped(bool left = false)
	Form f = PlayerRef.getEquippedObject(1 - (left as int))
	return (f && f != Unarmed)
endFunction