Scriptname GLT_Shop_JewelryScript extends ObjectReference  

Armor Property ThisArmor Auto
Actor Property PlayerRef Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	PlayerRef.equipItem(ThisArmor)
endEvent