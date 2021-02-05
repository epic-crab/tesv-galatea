Scriptname GLT_Replaceable_MagicEffect extends GLT_Replaceable
{Script attached to magic effects on forms that can't have scripts and need to be replaced - eg, potions, scrolls.}

Form Property ThisItem Auto

function replace(ObjectReference sourceContainer, ObjectReference destContainer = None)
	int count = sourceContainer.getItemCount(ThisItem)
	sourceContainer.removeItem(ThisItem, count)
	if(OtherForm && destContainer)
		destContainer.addItem(OtherForm, count)
	elseif(OtherForm)
		sourceContainer.addItem(OtherForm, count)
	endIf
endFunction