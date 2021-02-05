Scriptname GLT_SpellReplaceable extends GLT_Replaceable  

function replace(ObjectReference sourceContainer, ObjectReference destContainer = None)
	int count = sourceContainer.getItemCount(self)
	sourceContainer.removeItem(self, count)
	LeveledItem LItem = OtherForm as LeveledItem
	if(!LItem)
		return
	endIf
	int randMax = LItem.GetNumForms() - 1
	while count > 0
		Form tome = LItem.getNthForm(Utility.randomInt(0, randMax))
		if(OtherForm && destContainer)
			destContainer.addItem(tome, 1)
		elseif(OtherForm)
			sourceContainer.addItem(tome, 1)
		endIf
		count -= 1
	endWhile
endFunction