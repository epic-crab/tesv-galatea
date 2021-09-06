Scriptname GLT_Shop_SpellScript extends GLT_Shop_ItemScript  

Spell Property thisSpell Auto
MiscObject Property thisMisc Auto

function addToPlayer()
	PlayerRef.addSpell(thisSpell, false)
	PlayerRef.RemoveItem(thisMisc, 1, true)
	equipNewItem(thisSpell)
endFunction