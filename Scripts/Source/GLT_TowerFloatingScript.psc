Scriptname GLT_TowerFloatingScript extends ObjectReference  

float pi = 3.14159265
float xBase
float yBase
float zBase
float axBase
float azBase
float theta
float speed
float elevRange
float daz
float targAz
float tanMag
float property radius = 800.0 auto
float property radiusRange = 150.0 auto
float property axRange = 8.0 auto
float property rotationPeriod = 36.0 auto
float property orbitPeriod = 600.0 auto
float property dTheta = 30.0 auto
ObjectReference Property finalDest auto
ObjectReference Property interiorEnabler auto
float property destTime = 8.4 auto
float property riseTime = 5.0 auto
Sound property inPositionThud auto

ObjectReference Property lastBridge auto
EffectShader Property Disintegrate Auto
EffectShader Property UnDisintegrate Auto

Event OnInit()
	xBase = getPositionX()
	yBase = getPositionY()
	zBase = getPositionZ()
	axBase = getAngleX()
	azBase = getAngleZ()
	speed = 2.0*pi*radius/orbitPeriod
	theta = Utility.randomFloat(0.0, 360.0)
	daz = orbitPeriod/rotationPeriod * dTheta
	tanMag = 2.0 * Math.sin(dTheta/2.0) * radius
	elevRange = tanMag * Math.tan(axRange)
endEvent

auto state floating
	Event OnCellAttach()
		Utility.wait(1.0)
		float targX = xBase + radius*Math.cos(theta)
		float targY = yBase + radius*Math.sin(theta)
		float targZ = zBase + elevRange*Utility.randomFloat(-0.5, 0.5)
		float dz = targZ - getPositionZ()
		float targax = Math.atan(dz/tanMag)
		targaz = getAngleZ() - daz
		SplineTranslateTo(targX, targY, targZ, targax, 0.0, targaz, tanMag, speed)
	endEvent
	Event OnTranslationAlmostComplete()
		theta = theta + dTheta
		if(theta > 360.0)
			theta -= 360.0
		endIf
		float r = radius + radiusRange*Utility.randomFloat(-0.5, 0.5)
		float targX = xBase + r*Math.cos(theta)
		float targY = yBase + r*Math.sin(theta)
		float targZ = zBase + elevRange*Utility.randomFloat(-0.5, 0.5)
		float targax = axBase + axRange*Utility.randomFloat()
		targaz -= daz
		SplineTranslateTo(targX, targY, targZ, targax, 0.0, targaz, tanMag, speed)
		if(targAz < 0)
			targAz += 360.0
		endIf
	endEvent
endState

state transition
	Event OnBeginState()
		StopTranslation()
		float destX = finalDest.X
		float destY = finalDest.Y
		float destZ = zBase
		float dx = destX - getPositionX()
		float dy = destY - getPositionY()
		float dz = destZ - getPositionZ()
		speed = Math.sqrt(dx*dx + dy*dy + dz*dz)/destTime
		SplineTranslateTo(destX, destY, destZ, 0.0, 0.0, 0.0, tanMag, speed)
		goToState("locked")
	endEvent
endState

state locked
	Event OnTranslationAlmostComplete()
		float destSpeed = (finalDest.Z - getPositionZ())/riseTime
		TranslateTo(finalDest.X, finalDest.Y, finalDest.Z, 0.0, 0.0, finalDest.getAngleZ(), destSpeed)
		goToState("finished")
	endEvent
endState

state finished
	Event OnTranslationAlmostComplete()
		int soundInstance = inPositionThud.play(self)
		Game.shakeCamera(self, 0.8, 0.2)
	endEvent
	Event OnTranslationComplete()
		interiorEnabler.enableNoWait()
		UnDisintegrate.play(lastBridge, 0.6)
		Disintegrate.stop(lastBridge)
	endEvent
endState