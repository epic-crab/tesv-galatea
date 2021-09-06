Scriptname GLT_Shop_ClothesScript extends GLT_Shop_ItemScript  

Armor Property Accessories Auto
Armor Property ThisArmor Auto

function addToPlayer()
	PlayerRef.addItem(Accessories, 1, true)
	replaceRags(thisArmor)
endFunction