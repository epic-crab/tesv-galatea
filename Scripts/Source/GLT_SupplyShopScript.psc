Scriptname GLT_SupplyShopScript extends ObjectReference conditional

bool property PickaxeMade = false auto conditional
bool property WoodAxeMade = false auto conditional
bool property TorchMade = false auto conditional
ObjectReference Property Shop Auto

Event OnActivate(ObjectReference actronaut)
	Shop.activate(actronaut)
endEvent