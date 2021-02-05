Scriptname GLT_Replaceable extends Form

Form Property OtherForm Auto

function replace(ObjectReference sourceContainer, ObjectReference destContainer = None)
	int count = sourceContainer.getItemCount(self)
	sourceContainer.removeItem(self, count)
	if(OtherForm && destContainer)
		destContainer.addItem(OtherForm, count)
	elseif(OtherForm)
		sourceContainer.addItem(OtherForm, count)
	endIf
endFunction