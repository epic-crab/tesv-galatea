Scriptname GLT_ClassContainerScript extends ObjectReference  

Actor Property PlayerRef Auto
GLTQ01 Property CharacterCreation Auto
GLT_ClassItem lastSelectedClass
bool checkEnabled
FormList Property AllClassItems auto
GLT_ClassActivatorScript Property ClassSelector Auto

Event OnLoad()
	AddItem(AllClassItems, 1)
endEvent

Event OnActivate(ObjectReference ref)
	checkEnabled = false
	lastSelectedClass = None
	Utility.wait(1.0)
	if(!lastSelectedClass)
		ClassSelector.resetSelector()
	endIf
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	lastSelectedClass = akBaseItem as GLT_ClassItem
	if(!checkEnabled)
		checkEnabled = true
		CharacterCreation.closeContainerMenu()
		checkSelectedClass()
	endIf
endEvent

function checkSelectedClass()
	Utility.wait(0.1)
	checkEnabled = false
	int count = PlayerRef.getItemCount(AllClassItems)
	PlayerRef.RemoveItem(AllClassItems, count, true, self)
	int choice = lastSelectedClass.ClassDescription.show()
	;if selected, tell the character creation quest to handle that
	if(choice == 0)
		CharacterCreation.ClassItemSelected(lastSelectedClass)
	;otherwise, reopen the menu
	else
		activate(PlayerRef)
	endIf
endFunction