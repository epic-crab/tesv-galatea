scriptname GLT_Shop_ArmorScript extends ObjectReference

GLT_Disappearable Property Bust Auto
Armor Property Helmet Auto
Armor Property ThisArmor Auto
Armor Property Rags Auto
Actor Property PlayerRef Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto
GLT_ArmorShopScript property shop auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	PlayerRef.addItem(Helmet, 1, true)
	if(ThisArmor.hasKeyword(ArmorHeavy))
		shop.HeavyArmorMade = true
	elseif(ThisArmor.hasKeyword(ArmorLight))
		shop.LightArmorMade = true
	else
		shop.RobesMade = true
	endIf
	Bust.GoToState("vanished")
	if(PlayerRef.isEquipped(Rags))
		PlayerRef.equipItem(ThisArmor)
		PlayerRef.removeItem(Rags, 1, true)
	endIf
endEvent