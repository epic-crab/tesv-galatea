Scriptname GLTBG_Refugee_PlayerAlias extends ReferenceAlias  

FormList Property HousePurchaseList Auto

Event OnInit()
	AddInventoryEventFilter(HousePurchaseList)
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if(HousePurchaseList.hasForm(akBaseItem))
		getOwningQuest().setStage(20)
	endIf
endEvent