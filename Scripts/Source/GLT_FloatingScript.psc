Scriptname GLT_FloatingScript extends ObjectReference  

float zPosBase
float zAngleBase
float zSpeed

float property elevRange auto
float property elevVarRange auto
float property angleRange auto
float property period auto

Event OnInit()
	zPosBase = GetPositionZ()
	zAngleBase = GetAngleZ()
	zSpeed = elevRange/period
	RegisterForSingleUpdate(0.2)
endEvent

Event OnUpdate()
	float zTarget = zPosBase + elevRange/2.0 + elevVarRange * Utility.randomFloat(-0.5, 0.5)
	float angleTarget = zAngleBase + angleRange * Utility.randomFloat(-0.5, 0.5)
	translateTo(GetPositionX(), GetPositionY(), zTarget, GetAngleX(), GetAngleY(), angleTarget, zSpeed)
endEvent

Event OnTranslationComplete()
	if(is3dloaded())
		float upDown = 1.0
		if(GetPositionZ() >= zPosBase)
			upDown = -1.0
		endIf
		float zTarget = zPosBase + elevRange * upDown + elevVarRange * Utility.randomFloat(-0.5, 0.5)
		float angleTarget = zAngleBase + angleRange * Utility.randomFloat(-0.5, 0.5)
		translateTo(GetPositionX(), GetPositionY(), zTarget, GetAngleX(), GetAngleY(), angleTarget, zSpeed)
	endIf
endEvent