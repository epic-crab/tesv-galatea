Scriptname GLT_ArmorShopScript extends ObjectReference conditional

bool property RobesMade = false auto conditional
bool property LightArmorMade = false auto conditional
bool property HeavyArmorMade = false auto conditional
ObjectReference Property Shop Auto

Event OnActivate(ObjectReference actronaut)
	Shop.activate(actronaut)
endEvent