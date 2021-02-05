Scriptname GLTBQBountyScript extends ReferenceAlias

Quest property GLT101 auto

Event OnDeath(Actor akKiller)
	Quest q = GetOwningQuest()
	if(q.getStageDone(10))
		q.setStage(100)
	else
		q.stop()
	endIf
	GLT101.start()
EndEvent
