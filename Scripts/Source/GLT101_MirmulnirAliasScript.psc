Scriptname GLT101_MirmulnirAliasScript extends ReferenceAlias  

;short and simple, per behavior exclusive to GLT101. Other behavior covered by the Mirmulnir handler, as making him the representative first dragon has made him surprisingly important to this mod.
Actor selfRef

Event OnInit()
	selfRef = getReference() as Actor
endEvent

Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
	selfRef.startCombat(akTarget as Actor)
	getOwningQuest().setStage(20)
endEvent