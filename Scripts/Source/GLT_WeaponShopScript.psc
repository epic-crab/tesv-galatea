Scriptname GLT_WeaponShopScript extends ObjectReference conditional

bool property SwordMade = false auto conditional
bool property WarAxeMade = false auto conditional
bool property MaceMade = false auto conditional
bool property DaggerMade = false auto conditional
bool property ShieldMade = false auto conditional
bool property GreatSwordMade = false auto conditional
bool property BattleaxeAxeMade = false auto conditional
bool property WarhammerMade = false auto conditional
bool property BowMade = false auto conditional
bool property StaffMade = false auto conditional
ObjectReference Property Shop Auto

Event OnActivate(ObjectReference actronaut)
	Shop.activate(actronaut)
endEvent