Scriptname GLT_TraitBookScript extends GLT_Disappearable  

Actor Property PlayerRef Auto
Message Property TooManyTraits Auto
Message Property ConfirmOppositeRemoval Auto
Spell Property thisTrait auto hidden
Message Property thisTraitDescription auto hidden
Spell[] Property thisTraitOpposites auto hidden
ObjectReference Property dest auto
GLT_TraitCatalogScript Property catalog auto

function assignTrait(GLT_TraitItem trait)
	thisTrait = trait.Trait
	thisTraitDescription = trait.TraitDescription
	thisTraitOpposites = trait.OppositeTraits
	setDisplayName(thisTrait.getName())
	trait.AssignedBook = self
endFunction

Event OnActivate(ObjectReference actronaut)
	int choice = thisTraitDescription.show()
	if(choice == 0 && checkMax() && checkAndRemoveOpposites())
		catalog.addTrait(thisTrait)
		disappear()
	endIf
endEvent

bool function checkMax()
	if(catalog.traitsTaken >= (catalog.TraitsMax.getValue() as int))
		TooManyTraits.show()
		return false
	endIf
	return true
endFunction

bool function checkAndRemoveOpposites()
	bool confirmed = false
	int i = 0
	while i < thisTraitOpposites.length
		Spell opposite = thisTraitOpposites[i]
		if(PlayerRef.hasSpell(opposite))
			if(!confirmed)
				int choice = ConfirmOppositeRemoval.show()
				if(choice == 0)
					confirmed = true
					catalog.removeTrait(opposite)
				else
					return false
				endIf
			else
				catalog.removeTrait(opposite)
			endIf
		endIf
		i += 1
	endWhile
	return true
endFunction

function queueDisappear()
	Utility.wait(0.1)
	registerForSingleUpdate(15.0)
endFunction
Event OnUpdate()
	if(getState() != "vanished")
		goToState("vanished")
	endIf
	if(catalog.lastPlacedBook == self)
		catalog.bookTimeoutCallback()
	endIf
endEvent

state vanished
	Event OnBeginState()
		GLT_Disintegrate01FXS.play(self)
		Utility.wait(1.5)
		moveTo(dest)
		GLT_Disintegrate01FXS.stop(self)
	endEvent
	function MoveTo(ObjectReference akTarget, float afXOffset = 0.0, float afYOffset = 0.0, float afZOffset = 0.0, bool abMatchRotation = true)
		goToState("")
		parent.moveTo(akTarget, afXOffset, afYOffset, afZOffset, abMatchRotation)
	endFunction
endState