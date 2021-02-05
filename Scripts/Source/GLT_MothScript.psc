Scriptname GLT_MothScript extends critter  
{Main Behavior script for moths and butterflies}

import Utility
import form
import debug

; Properties (set through the editor)
FormList property PlantTypes auto
{ The list of plant types this moth can be attracted to}

; Constants
float Property fTimeAtPlantMin = 5.0 auto
{The Minimum time a Moth stays at a plant}
float Property fTimeAtPlantMax = 10.0 auto
{The Maximum time a Moth stays at a plant}
float Property fActorDetectionDistance = 300.0 auto
{The Distance at which an actor will trigger a flee behavior}
float Property fTranslationSpeedMean = 150.0 auto
{The movement speed when going from plant to plant, mean value}
float Property fTranslationSpeedVariance = 50.0 auto
{The movement speed when going from plant to plant, variance}
float Property fFleeTranslationSpeed = 300.0 auto
{The movement speed when fleeing from the player}
float Property fBellShapePathHeight = 150.0 auto
{The height of the bell shaped path}
float Property fFlockPlayerXYDist = 100.0 auto
{When flocking the player, the XY random value to add to its location}
float Property fFlockPlayerZDistMin = 50.0 auto
{When flocking the player, the min Z value to add to its location}
float Property fFlockPlayerZDistMax = 200.0 auto
{When flocking the player, the max Z value to add to its location}
float Property fFlockTranslationSpeed = 300.0 auto
{When flocking the player, the speed at which to move}
float Property fMinScale = 0.5 auto
{Minimum initial scale of the Moth}
float Property fMaxScale = 1.2 auto
{Maximum initial scale of the Moth}
float property fMinTravel = 64.0 auto
{Minimum distance a wandering moth/butterfly will travel}
float property fMaxTravel = 512.0 auto 
{Maximum distance a wandering moth/butterfly will travel}
string property LandingMarkerPrefix = "LandingSmall0" auto
{Prefix of landing markers on plants, default="LandingSmall0"}
float property fMaxRotationSpeed = 90.0 auto
{Max rotation speed while mocing, default = 90 deg/s}

GlobalVariable Property IsDragonborn Auto
EffectShader Property Disintegrate Auto
EffectShader Property UnDisintegrate Auto
GLT_DragonIslandTriggerboxScript Property DragonIsland Auto

; Variables
int iPlantTypeCount = 0

; Constants
float fWaitingToDieTimer = 10.0


; Called by the spawner to kick off the processing on this Moth
Event OnStart()
	iPlantTypeCount = PlantTypes.GetSize()
	SetScale(RandomFloat(fMinScale, fMaxScale))
	if !(PlayerRef.GetDistance(self) <= fMaxPlayerDistance )
		DisableAndDelete()
	else
		WarpToNewPlant()
		Enable()
		int c = 0
		int max = 10 ; limit recursions
		while(!Is3DLoaded()&& (c < max))
			wait(0.1)
			c+=1
		endWhile
		if (Is3DLoaded())
			UnDisintegrate.play(self, 3.0)
			SetMotionType(Motion_Keyframed, false)
			RegisterForSingleUpdate(0.0)
		else
			DisableAndDelete(false)
		endIf
	endIf
endEvent
ObjectReference currentPlant = none
State AtPlant
	Event OnUpdate()
		if !(PlayerRef.GetDistance(self) <= fMaxPlayerDistance )
			DisableAndDelete()
		elseif (spawner.iCurrentCritterCount > spawner.iMaxCritterCount) || (spawner.iCurrentCritterCount < 0)
			disableAndDelete()
		else
			if (ShouldFlockAroundPlayer())
				DoPathStartStuff()
				FlockToPlayer()
			else
				if (Spawner.IsActiveTime())
					Actor closestActor = Game.FindClosestActorFromRef(self, fActorDetectionDistance)
					float fspeed = 0.0
					if (closestActor != none)
						fspeed = fFleeTranslationSpeed
					else
						fspeed = RandomFloat(fTranslationSpeedMean - fTranslationSpeedVariance, fTranslationSpeedMean + fTranslationSpeedVariance)
					endIf
					GoToNewPlant(fspeed)
				else
					BellShapeTranslateToRefAtSpeedAndGotoState(Spawner, fBellShapePathHeight, fTranslationSpeedMean, fMaxRotationSpeed, "KillForTheNight")
				endIf
			endIf
		endIf
	endEvent
	Event OnCritterGoalReached()
; 		traceConditional(self + " reached goal", bCritterDebug)
		if !(PlayerRef.GetDistance(self) <= fMaxPlayerDistance )
			DisableAndDelete()
		else
			if (Game.FindClosestActorFromRef(self, fActorDetectionDistance) != none)
				RegisterForSingleUpdate(0.0)
			else
				RegisterForSingleUpdate(RandomFloat(fTimeAtPlantMin, fTimeAtPlantMax))
			endIf
		endIf
	EndEvent
endState

; When the player is dragonborn, follow them
State FollowingPlayer
	Event OnCritterGoalReached()
		if (!(Spawner.GetDistance(self) >= fLeashLength) && ShouldFlockAroundPlayer())
			FlockToPlayer()
		else
			GoToNewPlant(fFlockTranslationSpeed)
		endIf
	endEvent

endState

; When the moths go to sleep, they get deleted
State KillForTheNight
	Event OnCritterGoalReached()
		DisableAndDelete()
	endEvent
endState

Event OnUpdate()
	UnregisterForUpdate()
	DisableAndDelete()
endEvent

bool Function ShouldFlockAroundPlayer()
	return IsDragonborn.getValue() > 0.0 && DragonIsland.playerInMothFlockRange
endFunction

Function FlockToPlayer()
	gotoState("FollowingPlayer")
	float ftargetX = PlayerRef.X + RandomFloat(-fFlockPlayerXYDist, fFlockPlayerXYDist)
	float ftargetY = PlayerRef.Y + RandomFloat(-fFlockPlayerXYDist, fFlockPlayerXYDist)
	float ftargetZ = PlayerRef.Z + RandomFloat(fFlockPlayerZDistMin, fFlockPlayerZDistMax)
	float ftargetAngleZ = RandomFloat(-180, 180)
	float ftargetAngleX = RandomFloat(-20, 20)
	float fpathCurve = RandomFloat(fPathCurveMean - fPathCurveVariance, fPathCurveMean + fPathCurveVariance)
	SplineTranslateTo(ftargetX, ftargetY, ftargetZ, ftargetAngleX, 0.0, ftargetAngleZ, fpathCurve, fFlockTranslationSpeed, fMaxRotationSpeed)
endFunction

; Finds a new plant to fly to
ObjectReference Function PickNextPlant()
	; Look for a random plant within the radius of the Spawner
	int isafetyCheck = 0
	ObjectReference newPlant = CurrentPlant
	bool bnewPlantValid = false
	float fspawnerX = Spawner.X
	float fspawnerY = Spawner.Y
	float fspawnerZ = Spawner.Z
	while (!bnewPlantValid && (isafetyCheck < 5))
		newPlant = Game.FindRandomReferenceOfAnyTypeInList(PlantTypes, fSpawnerX, fSpawnerY, fSpawnerZ, fLeashLength)
		bnewPlantValid = false
		if (newPlant != none && newPlant != currentPlant)
			if (Game.FindClosestActorFromRef(newPlant, fActorDetectionDistance) == none)
				bnewPlantValid = true
			endIf
		endIf
		isafetyCheck = isafetyCheck + 1
	endWhile
	
	if (isafetyCheck == 5)
		return none
	else
		return newPlant
	endIf
endFunction

Function GoToNewPlant(float afSpeed)
	ObjectReference newPlant = PickNextPlant()
	
	if (newPlant != none)
		currentPlant = newPlant
		; Pick random landing node
		; And start moving towards it
		string landingMarkerName = LandingMarkerPrefix + RandomInt(1, 3)
		if (newPlant.HasNode(landingMarkerName))
			BellShapeTranslateToRefNodeAtSpeedAndGotoState(CurrentPlant, landingMarkerName, fBellShapePathHeight, afSpeed, fMaxRotationSpeed, "AtPlant")
		else
			string firstMarkerName = LandingMarkerPrefix + 1
			if (newPlant.HasNode(firstMarkerName))
				BellShapeTranslateToRefNodeAtSpeedAndGotoState(CurrentPlant, firstMarkerName, fBellShapePathHeight, afSpeed, fMaxRotationSpeed, "AtPlant")
			else
				BellShapeTranslateToRefAtSpeedAndGotoState(CurrentPlant, fBellShapePathHeight, afSpeed, fMaxRotationSpeed, "AtPlant")
			endIf		
		endIf
			
	else
		RegisterForSingleUpdate(fWaitingToDieTimer)
	endIf
endFunction

Function WarpToNewPlant()
	ObjectReference newPlant = PickNextPlant()
	if (newPlant != none)
		currentPlant = newPlant
		string landingMarkerName = LandingMarkerPrefix + RandomInt(1, 3)
		if (newPlant.HasNode(landingMarkerName))
			WarpToRefNodeAndGotoState(CurrentPlant, landingMarkerName, "AtPlant")
		else
			string firstMarkerName = LandingMarkerPrefix + 1
			if (newPlant.HasNode(firstMarkerName))
				WarpToRefNodeAndGotoState(CurrentPlant, firstMarkerName, "AtPlant")
			else
				WarpToRefAndGotoState(CurrentPlant, "AtPlant")
			endIf
		endIf
			
	else
		RegisterForSingleUpdate(fWaitingToDieTimer)
	endIf
endFunction

EVENT onCellDetach()
	DisableAndDelete()
endEVENT

EVENT onActivate(objectReference actronaut)
	disableAndDelete()
endEVENT

Function DisableAndDelete(bool abFadeOut = true)
	Disintegrate.play(self)
	Utility.wait(1.0)
	Parent.DisableAndDelete(false)
endFunction