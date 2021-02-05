scriptname GLT_BackgroundActor extends Actor

GLT_BackgroundQuest property background auto hidden
EffectShader Property Disintegrate auto hidden
EffectShader Property UnDisintegrate auto hidden

Event OnActivate(ObjectReference actronaut)
	background.select()
endEvent

Event OnDeath(Actor akKiller)
	Disintegrate.play(self)
	Utility.wait(3.5)
	resurrect()
	Utility.wait(1.0)
	UnDisintegrate.play(self, 2.1)
	Disintegrate.stop(self)
endEvent