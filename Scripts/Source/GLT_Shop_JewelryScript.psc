Scriptname GLT_Shop_JewelryScript extends GLT_Shop_ItemScript  

Armor Property ThisArmor Auto

function addToPlayer()
	PlayerRef.equipItem(ThisArmor)
endFunction