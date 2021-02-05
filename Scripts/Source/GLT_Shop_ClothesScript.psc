Scriptname GLT_Shop_ClothesScript extends ObjectReference  

Armor Property Accessories Auto
Armor Property ThisArmor Auto
Armor Property Rags Auto
Actor Property PlayerRef Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	PlayerRef.addItem(Accessories, 1, true)
	if(PlayerRef.isEquipped(Rags))
		PlayerRef.equipItem(ThisArmor)
		PlayerRef.removeItem(Rags, 1, true)
	endIf
endEvent