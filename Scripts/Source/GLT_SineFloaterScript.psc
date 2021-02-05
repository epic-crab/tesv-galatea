Scriptname GLT_SineFloaterScript extends ObjectReference  

float zPosBase
float zAngleBase
float time

float property updateRate auto
float property elevRange auto
float property elevVarRange auto
float property period auto
float property angleRange auto

Event OnInit()
	time = 0.0
	zPosBase = GetPositionZ()
	zAngleBase = GetAngleZ()
	registerForSingleUpdate(updateRate)
endEvent

Event OnUpdate()
	if(is3DLoaded())
		float targetZ = elevRange*Math.sin(360.0 * time/period) + zPosBase + elevVarRange*Utility.randomFloat(-0.5, 0.5)
		float speedZ = Math.abs(elevRange * Math.cos(360.0/period) * 360.0/period) + 0.001 ; just in case
		float angleZ = zAngleBase + angleRange * Utility.randomFloat(-0.5, 0.5)
		translateTo(GetPositionX(), GetPositionY(), targetZ, GetAngleX(), GetAngleY(), angleZ, speedZ, 1.0)
		time += updateRate
		registerForSingleUpdate(updateRate)
	endIf
endEvent
