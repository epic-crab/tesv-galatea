Scriptname GLT_Shop_WeaponScript extends GLT_Shop_ItemScript  

GLT_Disappearable Property Display Auto
Weapon Property ThisWeapon Auto
Armor Property ThisShield Auto
GLT_WeaponShopScript property shop auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if(ThisWeapon)
		equipNewItem(ThisWeapon)
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
		equipNewItem(ThisShield)
		shop.ShieldMade = true
	endIf
	Display.goToState("vanished")
endEvent