Scriptname GLT_TraitCatalogScript extends ObjectReference  

Actor Property PlayerRef Auto
GLTQ01 Property Chargen Auto
GLT_TraitBookScript[] Property Books auto
Activator[] Property BaseTraitBooks auto
Formlist Property AllTraits Auto
ObjectReference dest
int property traitsTaken auto
GlobalVariable Property TraitsMax Auto
Formlist Property TakenTraits Auto
Message Property TraitsMenu Auto

GLT_TraitBookScript property lastPlacedBook auto
ObjectReference[] Property BookMarkers Auto
int bookIndex

function addTrait(Spell trait)
	if(!PlayerRef.hasSpell(trait))
		PlayerRef.addSpell(trait)
		TakenTraits.addForm(trait)
		traitsTaken += 1
	endIf
endFunction
function removeTrait(Spell trait)
	if(PlayerRef.hasSpell(trait))
		PlayerRef.removeSpell(trait)
		TakenTraits.removeAddedForm(trait)
		traitsTaken -= 1
	endIf
endFunction
function placeTrait(GLT_TraitBookScript traitBook)
	lastPlacedBook = traitBook
	ObjectReference xMarker = BookMarkers[bookIndex]
	bookIndex = (bookIndex + 1) % BookMarkers.length
	traitBook.moveTo(xMarker)
	traitBook.queueDisappear()
endFunction
function bookTimeoutCallback()
	bookIndex = 0
endFunction

Event OnCellAttach()
	bookIndex = 0
	Utility.wait(5.0) ; for all other startup script nonsense to have a chance to breathe
	int i = 0
	int n = Books.length
	int nBooks = n
	int nTraits = AllTraits.getSize()
	if(nTraits > n)
		n = nTraits
	endIf
	while i < n
		GLT_TraitBookScript nextBook
		if(i < nBooks)
			nextBook = Books[i]
		else
			nextBook = dest.placeAtMe(BaseTraitBooks[Utility.randomInt(0, BaseTraitBooks.length)]) as GLT_TraitBookScript
		endIf
		if(i < nTraits)
			GLT_TraitItem nextTrait = AllTraits.getAt(i) as GLT_TraitItem
			nextBook.assignTrait(nextTrait)
		else
			nextBook.disappear()
		endIf
		i += 1
	endWhile
endEvent

Event onActivate(objectReference Actronaut)
	if Actronaut == PlayerRef
		float maxTraits = TraitsMax.getValue()
		float freeTraits = maxTraits - (traitsTaken as float)
		int choice = TraitsMenu.show(freeTraits, maxTraits)
		if(choice == 0)
			int i = TakenTraits.getSize()
			while i > 0
				i -= 1
				Spell s = TakenTraits.getAt(i) as Spell
				removeTrait(s)
			endWhile
		elseif(choice == 1)
			Chargen.showTraitMenu()
		endIf
	endif
EndEvent