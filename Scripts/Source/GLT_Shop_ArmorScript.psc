scriptname GLT_Shop_ArmorScript extends GLT_Shop_ItemScript

GLT_Disappearable Property Bust Auto
Armor Property Helmet Auto
Armor Property ThisArmor Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto
GLT_ArmorShopScript property shop auto

function addToPlayer()
	PlayerRef.addItem(Helmet, 1, true)
	if(ThisArmor.hasKeyword(ArmorHeavy))
		shop.HeavyArmorMade = true
	elseif(ThisArmor.hasKeyword(ArmorLight))
		shop.LightArmorMade = true
	else
		shop.RobesMade = true
	endIf
	Bust.GoToState("vanished")
	replaceRags(ThisArmor)
endFunction