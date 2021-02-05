;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_GLTQ003_MirmulnirHandler_0546C69B Extends Quest Hidden

;BEGIN ALIAS PROPERTY Mirmulnir
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Mirmulnir Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Whiterun
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Whiterun Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MQ104StartingPosition
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MQ104StartingPosition Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Home
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Home Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AncientsAscent
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_AncientsAscent Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HelgenOrbitMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HelgenOrbitMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MenaceWhiterunPosition
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MenaceWhiterunPosition Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AAMapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AAMapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Chargen.GLT_Active.setValue(0.0)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Alias_Mirmulnir.tryToDisable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
int skipThroughQuest = 102
if(MQ102.isRunning())
	skipThroughQuest = 103
endIf
if(MQ103.isRunning())
	skipThroughQuest = 104
endIf
bypassMQ(skipThroughQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
if(isObjectiveDisplayed(1))
setObjectiveCompleted(1)
endIf
if(GLT101.isRunning())
GLT101.setStage(35)
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
function goToHelgen()
	Actor MirmulnirRef = Alias_Mirmulnir.getReference() as Actor
	ActorBase MirmulnirBase = MirmulnirRef.getActorBase()
	MirmulnirBase.setEssential(true) ; for some reason moving him keeps killing him
	ObjectReference HelgenOrbitMarker = Alias_HelgenOrbitMarker.getReference()
	Alias_Mirmulnir.tryToDisable()
	Alias_Mirmulnir.tryToMoveTo(HelgenOrbitMarker)
	Alias_Mirmulnir.tryToEnable()
	Alias_Mirmulnir.tryToEvaluatePackage()
	MirmulnirBase.setEssential(false)
endFunction

function stopCombatFlyToWhiterun()
	Actor mirmulnir = Alias_Mirmulnir.getReference() as Actor
	defaultAggression = mirmulnir.GetActorValue("Aggression")
	mirmulnir.setActorValue("Aggression", 0)
	mirmulnir.stopCombat()
	mirmulnir.evaluatePackage()
endFunction

function goHomeWhenPlayerIsntLooking(float delay = 0.0)
	if(delay > 0.0)
		Utility.wait(delay)
	endIf
	RegisterForSingleLOSLost(Game.getPlayer(), Alias_Mirmulnir.getReference())
endFunction

Event OnLostLOS(Actor akViewer, ObjectReference akTarget)
	GLT101.setStage(30)
	Alias_Mirmulnir.tryToDisable()
	Alias_Mirmulnir.tryToMoveTo(Alias_Home.getReference())
	Alias_Mirmulnir.tryToEnable()
	(Alias_Mirmulnir.getReference() as Actor).setActorValue("Aggression", defaultAggression)
endEvent

function goToPreMQ104()
	Alias_Mirmulnir.tryToDisable()
	Alias_Mirmulnir.tryToMoveTo(Alias_MQ104StartingPosition.getReference())
endFunction

function bypassMQ(int from = 102)
	bool isDragonborn = Chargen.IsDragonborn.getValue() > 0.0
	if(isDragonborn && from <= 104)
		;first, do shout stuff because that's most obvious to the player
		Game.getPlayer().setActorValue("Dragon Souls", 0)
		Game.teachWord(Fus)
		Game.unlockWord(Fus)
		MQ104.AllowPlayerShout.value = 1
	endIf
	;MQ 102
	if(from <= 102)
		MQ102.Fragment_81()
		MQ102.Fragment_48()
	endIf
	;MQ 103
	if(from <= 103)
		MQReserved.setStage(10)
		MQ102.WIFunctions.AllowComplexInteractions(Riverwood)
		MQ103.RiverwoodGuardsEnableMarker.Enable()
		MQ103.RiverwoodGuardCampEnableMarker.Enable()
		MQ103.SleepingGiantIntroTrigger.Disable()
		theGoddamnCivilWar.AddGarrisonBackToWar(Riverwood)
		dunDragonMoundQST.SetStage(10)
	endIf
	;MQ 104
	if(from <= 104)
		MQ104.FortAttackEnableMarker.Disable()
		MQ104.FortAttackNearbySpawnsMarker.disable()
		MQ104.FortAttackFXEnableMarker.Enable()
		MQ104.FortSoldiersEnableMarker.Disable()
		MQ104.FortAttackFXEnableMarker.Disable()
		MQ104.FortAttackNearbySpawnsMarker.enable()
		MQ104.FortSoldiersEnableMarker.Enable()
		theGoddamnCivilWar.AddGarrisonBackToWar(WhiterunWatchtower)
		dunDragonMoundQST.SetStage(20)
	endIf
	if(isDragonborn)
		MQGreybeardCallKeyword.SendStoryEvent()
		MQ105.setstage(5)
	else
		MQ105.DragonEnableMarker.enable()
		MQ105.DragonsEnabled.SetValueInt(1)
	endIf
	Chargen.GLT_Active.setValue(0.0)
	stop()
endFunction

GLTQ01 Property Chargen Auto
Quest Property GLT101 Auto
Quest Property MQReserved Auto
Quest Property dunDragonMoundQST Auto
CWScript Property theGoddamnCivilWar Auto
QF_MQ102_0004E50D Property MQ102 Auto
QF_MQ103_000D0800 Property MQ103 Auto
QF_MQ104B_0002610C Property MQ104 Auto
QF_MQ105_000242BA Property MQ105 Auto
Location Property Riverwood Auto
Location Property WhiterunWatchtower Auto
Keyword Property MQGreybeardCallKeyword Auto
WordOfPower Property Fus Auto
float defaultAggression
