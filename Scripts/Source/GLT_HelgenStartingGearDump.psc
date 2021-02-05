Scriptname GLT_HelgenStartingGearDump extends GLT_Disappearable

GLTQ01 Property Chargen Auto

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	RegisterForUpdate(1.0)
endEvent

Event OnUpdate()
	if GetNumItems() == 0
		blockActivation()
		Chargen.closeContainerMenu()
		disappear()
	endIf
endEvent