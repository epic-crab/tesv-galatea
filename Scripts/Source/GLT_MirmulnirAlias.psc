Scriptname GLT_MirmulnirAlias extends ReferenceAlias  

Event OnDeath(Actor akKiller)
	getOwningQuest().setStage(10)
endEvent