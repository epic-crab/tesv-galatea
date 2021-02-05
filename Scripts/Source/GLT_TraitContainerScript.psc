Scriptname GLT_TraitContainerScript extends ObjectReference  

Actor Property PlayerRef Auto
FormList Property AllTraitItems auto
GLT_TraitCatalogScript property catalog auto
GLTQ01 Property Chargen Auto
bool check

Event OnLoad()
	check = false
	AddItem(AllTraitItems, 1)
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	GLT_TraitItem selectedTrait = akBaseItem as GLT_TraitItem
	catalog.placeTrait(selectedTrait.AssignedBook as GLT_TraitBookScript)
	if(!check)
		check = true
		Chargen.closeContainerMenu()
		checkOnClose()
	endIf
endEvent

function checkOnClose()
	Utility.wait(0.1)
	check = false
	int count = PlayerRef.getItemCount(AllTraitItems)
	PlayerRef.RemoveItem(AllTraitItems, count, true, self)
endFunction