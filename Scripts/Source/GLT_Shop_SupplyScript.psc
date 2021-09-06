Scriptname GLT_Shop_SupplyScript extends GLT_Shop_ItemScript  

GLT_Disappearable Property Display Auto
GLT_SupplyShopScript Property shop Auto
int property thisItem = -1 Auto
{torch, pickaxe, woodcutter's axe}

function addToPlayer()
	if(thisItem == 0)
		shop.TorchMade = true
	elseif(thisItem == 1)
		shop.PickaxeMade = true
	elseif(thisItem == 2)
		shop.WoodAxeMade = true
	endIf
	Display.GoToState("vanished")
endFunction