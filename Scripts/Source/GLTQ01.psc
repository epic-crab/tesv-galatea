scriptname GLTQ01 extends Quest

GLTQF001 Property Fragments Auto
Actor Property PlayerRef Auto
ObjectReference Property HelgenMapMarker Auto
GlobalVariable Property GLT_Active Auto
EffectShader Property Disintegrate Auto
EffectShader Property UnDisintegrate Auto
ObjectReference Property Bridge00 Auto
ObjectReference Property Bridge01 Auto
ObjectReference Property Bridge02 Auto
ObjectReference Property Bridge03 Auto
ObjectReference Property Bridge04 Auto
ObjectReference Property Bridge05 Auto
ObjectReference Property Bridge06 Auto
ObjectReference Property Bridge07 Auto
ObjectReference Property Bridge08 Auto
ObjectReference Property Bridge09 Auto
ObjectReference Property SpiralStairs Auto
ObjectReference Property Library Auto

ObjectReference Property UnderwaterStartMarker Auto
ObjectReference Property WaterCollision Auto
ObjectReference Property WaterSurfaceMarker Auto

string[] property skills auto
Spell[] property MajorSkills auto
Spell[] property MinorSkills auto
GLT_SkillActivator[] property SkillActivators Auto
GlobalVariable Property MajorSkillsTotal Auto
GlobalVariable Property MinorSkillsTotal Auto
GlobalVariable Property MajorSkillsBoost Auto
GlobalVariable Property MinorSkillsBoost Auto
GlobalVariable Property FreeSkillPoints Auto
GlobalVariable Property MajorMinorDiff Auto

Race[] Property StartingSpell_Races Auto
MiscObject[] Property StartingSpell_Miscs Auto
GLT_ChargenPlayerAlias Property PlayerAlias Auto

GLT_ClassActivatorScript Property ClassSelector Auto
Message Property GLT_SkillsIntro Auto
ObjectReference Property ClassContainer Auto
ObjectReference Property TraitContainer Auto

GlobalVariable Property IsDragonborn Auto
GlobalVariable Property DragonsExist Auto

ReferenceAlias Property PortalMarkerAlias Auto
ObjectReference Property BlackPortalMarker Auto
ObjectReference Property ContinueMarker Auto

ObjectReference Property DoomswampHenge Auto
ObjectReference Property MarketPortal Auto
ObjectReference Property MarketStairs Auto
ObjectReference Property LibraryPortal Auto
ObjectReference Property DragonIslandHenge Auto
ObjectReference Property DragonIslandPortal Auto

QF_MQ101_0003372B Property MQ101 Auto
QF_MQ101DragonAttack_000D0593 Property MQ101DA Auto
GLT_BackgroundQuest Property SelectedBackground Auto
FormList Property BackgroundsList Auto
ObjectReference Property BackgroundBasePoint Auto

GLT_TowerFloatingScript Property Tower Auto
GLT_RecoveryScript Property RecoveryTrigger Auto
ObjectReference Property SkyrimPerspective Auto
GlobalVariable Property EnableTelekinesis Auto
Int Property ActivateKey Auto
MiscObject Property CollisionDisc Auto
Message Property Confirmation Auto
LocationAlias Property StartingLoc Auto
ReferenceAlias Property StartingGearDump Auto
GLT_HelgenStartingGearDump Property HelgenDump Auto
ObjectReference Property HelgenPostChargenMarker Auto

GLT_FactionMonitors Property GLTQ001_FactionMonitors Auto
Quest Property GLTQ002 Auto
Quest Property MirmulnirHandler Auto

function startDisintegrate()
	Bridge00.moveTo(Bridge00, 0.0, 0.0, -10.0)
	Disintegrate.play(Bridge00)
	Disintegrate.play(Bridge01)
	Disintegrate.play(Bridge02)
	Disintegrate.play(Bridge03)
	Disintegrate.play(Bridge04)
	Disintegrate.play(Bridge05)
	Disintegrate.play(Bridge06)
	Disintegrate.play(Bridge07)
	Disintegrate.play(Bridge08)
	Disintegrate.play(Bridge09)
	Disintegrate.play(SpiralStairs)
	Disintegrate.play(Library)
	Utility.wait(2.1)
	Bridge00.moveTo(Bridge00, 0.0, 0.0, 10.0)
endFunction

function prepUnderwaterStart()
	
	Utility.wait(1.0)
	WaterCollision.disable()
	Game.EnablePlayerControls(abMovement = true, abFighting = false, abCamSwitch = false, abLooking = false, abSneaking = false, abMenu = false, abJournalTabs = false)
endFunction

function handleStartingSkills()
	int baseSkill = Game.GetGameSettingInt("iAVDSkillStart")
	int majorBoost = 0
	int minorBoost = 0
	int i = 0
	int[] boosts = new int[18]
	; identify major boost
	while i < 18
		boosts[i] = 0
		int boost = (PlayerRef.getActorValue(skills[i]) as int) - baseSkill
		if(majorBoost < boost)
			majorBoost = boost
		endIf
		i += 1
	endWhile
	MajorSkillsBoost.setValue(majorBoost)
	i = 0
	; remove major boosts
	while i < 18
		int boost = (PlayerRef.getActorValue(skills[i]) as int) - baseSkill
		if(boost == majorBoost)
			boosts[i] = 2
			MajorSkillsTotal.mod(1.0)
			PlayerRef.setActorValue(skills[i], baseSkill)
		endIf
		i += 1
	endWhile
	i = 0
	; identify minor boost
	while i < 18
		int boost = (PlayerRef.getActorValue(skills[i]) as int) - baseSkill
		if(minorBoost < boost)
			minorBoost = boost
		endIf
		i += 1
	endWhile
	MinorSkillsBoost.setValue(minorBoost)
	MajorMinorDiff.setValue(majorBoost - minorBoost)
	updateCurrentInstanceGlobal(MajorSkillsBoost)
	updateCurrentInstanceGlobal(MinorSkillsBoost)
	updateCurrentInstanceGlobal(MajorMinorDiff)
	i = 0
	; remove all boosts
	while i < 18
		int boost = (PlayerRef.getActorValue(skills[i]) as int) - baseSkill
		if(boost == minorBoost)
			boosts[i] = 1
			MinorSkillsTotal.mod(1.0)
		endIf
		PlayerRef.setActorValue(skills[i], baseSkill)
		i += 1
	endWhile
	i = 0
	; add skill boosts
	while i < 18
		if(boosts[i] == 2); major
			PlayerRef.addSpell(MajorSkills[i])
			SkillActivators[i].select()
		elseif(boosts[i] == 1); minor
			PlayerRef.addSpell(MinorSkills[i])
			SkillActivators[i].select()
		endIf
		i += 1
	endWhile
	; starting spells
	i = StartingSpell_Races.find(PlayerRef.getRace())
	if(i > 0)
		PlayerRef.addItem(StartingSpell_Miscs[i])
	endIf
	PlayerAlias.checkSpellTokens()
	; finally, weapon speed mult fix
	PlayerRef.setActorValue("WeaponSpeedMult", 1.0)
	PlayerRef.setActorValue("LeftWeaponSpeedMult", 1.0)
	setStage(2)
endFunction

function removeAllSkills()
	int i = 0
	while i < 18
		if(PlayerRef.hasSpell(MajorSkills[i]))
			PlayerRef.removeSpell(MajorSkills[i])
			SkillActivators[i].deselect()
			FreeSkillPoints.mod(MajorSkillsBoost.getValue())
		elseif(PlayerRef.hasSpell(MinorSkills[i]))
			PlayerRef.removeSpell(MinorSkills[i])
			SkillActivators[i].deselect()
			FreeSkillPoints.mod(MinorSkillsBoost.getValue())
		endIf
		i += 1
	endWhile
endFunction

function closeContainerMenu()
	UI.Invoke("ContainerMenu", "_root.Menu_mc.onExitMenuRectClick")
endFunction

function ShowClassMenu()
	bool vanillaMode = true ; add some more complex behavior later using UIExtensions and JContainers
	Utility.wait(0.5)
	int choice = GLT_SkillsIntro.show()
	if(choice == 0) ; select new class
		if(vanillaMode)
			ClassContainer.activate(PlayerRef)
		endIf
	elseif(choice == 1) ; save to custom class
	
	else
		ClassSelector.resetSelector()
	endIf
endFunction

function ClassItemSelected(GLT_ClassItem clitem)
	removeAllSkills()
	string[] classSkills = clitem.FavoredSkills
	int numClassSkills = classSkills.length
	int i = 0
	int numMajorSkills = 0
	int numMinorSkills = 0
	int fSP = FreeSkillPoints.getValue() as int
	int maST = MajorSkillsTotal.getValue() as int
	int miST = MinorSkillsTotal.getValue() as int
	int majorBoost = MajorSkillsBoost.getValue() as int
	int minorBoost = MinorSkillsBoost.getValue() as int
	while i < numClassSkills
		int skillIndex = skills.find(classSkills[i])
		if (numMajorSkills < maST && fSP >= majorBoost)
			PlayerRef.addSpell(MajorSkills[skillIndex])
			SkillActivators[skillIndex].select()
			fSP -= majorBoost
			numMajorSkills += 1
		elseif (numMinorSkills < miST && fSP >= minorBoost)
			PlayerRef.addSpell(MinorSkills[skillIndex])
			SkillActivators[skillIndex].select()
			fSP -= minorBoost
			numMinorSkills += 1
		endIf
		i += 1
	endWhile
	FreeSkillPoints.setValue(fSP as float)
	updateCurrentInstanceGlobal(FreeSkillPoints)
	ClassSelector.resetSelector()
endFunction

function modFreeSkillPoints(int amount, bool redisplay = false)
	FreeSkillPoints.mod(amount)
	updateCurrentInstanceGlobal(FreeSkillPoints)
	if(redisplay)
	
	endIf
endFunction

function revokeFreeSpell(MiscObject spellToken, int count)
	if(getStage() < 15)
		PlayerAlias.revokeFreeSpell(spellToken)
	endIf
endFunction

function updateQuestMarkers()
	ObjectReference nextPortalRef = BlackPortalMarker
	ObjectReference nextContinueRef = ContinueMarker
	int stage = getStage()
	if (stage == 5)
		nextContinueRef = DoomswampHenge
	elseif (stage == 6)
		nextPortalRef = MarketPortal
		nextContinueRef = MarketStairs
	elseif (stage == 7)
		nextContinueRef = SpiralStairs
	elseif (stage == 8)
		nextPortalRef = LibraryPortal
		nextContinueRef = DragonIslandHenge
	elseif (stage == 9)
		PortalMarkerAlias.forceRefTo(ContinueMarker)
		nextContinueRef = DragonIslandPortal
	endIf
	BlackPortalMarker.moveTo(nextPortalRef, afZOffset = 128.0)
	ContinueMarker.moveTo(nextContinueRef, afZOffset = 128.0)
endFunction

function showTraitMenu()
	bool vanillaMode = true
	if(vanillaMode)
		TraitContainer.activate(PlayerRef)
	else
	endIf
endFunction

function spawnBackgrounds()
	int i = 0
	int n = BackgroundsList.getSize()
	while (i < n)
		GLT_BackgroundQuest q = BackgroundsList.getAt(i) as GLT_BackgroundQuest
		q.init()
		i += 1
	endWhile
endFunction

function startTowerMovement()
	tower.goToState("transition")
endFunction

function selectSkyrimWorldspace()
	RecoveryTrigger.goToState("dormant")
	Game.DisablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = true, abLooking = false, abSneaking = true, abMenu = false, abActivate = false)
	Game.forceFirstPerson()
	Utility.wait(0.25)
	PlayerRef.translateToRef(SkyrimPerspective, PlayerRef.getDistance(SkyrimPerspective))
	Utility.wait(1.0)
	Game.EnablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = true, abLooking = true, abSneaking = true, abMenu = true, abActivate = true)
	EnableTelekinesis.setValue(1.0)
	ActivateKey = Input.getMappedKey("Activate")
	RegisterForKey(ActivateKey)
	registerForAnimationEvent(PlayerRef, "FootLeft")
	registerForAnimationEvent(PlayerRef, "FootRight")
endFunction

function leaveSkyrimWorldspace()
	UnregisterForKey(ActivateKey)
	unregisterForAnimationEvent(PlayerRef, "FootLeft")
	unregisterForAnimationEvent(PlayerRef, "FootRight")
	EnableTelekinesis.setValue(0.0)
endFunction

Event OnKeyDown(int keyCode)
	UnregisterForKey(ActivateKey)
	if(keyCode != ActivateKey || Utility.IsInMenuMode())
		return
	endIf
	GLT_StartLocationMarker ref = Game.getCurrentCrosshairRef() as GLT_StartLocationMarker
	if(ref)
		selectLocationMarker(ref)
	endIf
endEvent

function selectLocationMarker(GLT_StartLocationMarker ref)
	goToState("inSelection")
	Location loc = ref.thisLocation
	StartingLoc.forceLocationTo(loc)
	int choice = Confirmation.show()
	if(choice == 0)
		leaveSkyrimWorldspace()
		galateaStartGame()
	else
		RegisterForKey(ActivateKey)
	endIf
	goToState("")
endFunction
state inSelection
	Event OnKeyDown(int keyCode)
	endEvent
	function selectLocationMarker(GLT_StartLocationMarker ref)
	endFunction
endState

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	PlayerRef.placeAtMe(CollisionDisc)
endEvent

function restoreSkillBoosts()
	int i = 0
	int baseSkill = Game.getGameSettingInt("iAVDSkillStart")
	int majorBoost = MajorSkillsBoost.getValue() as int
	int minorBoost = MinorSkillsBoost.getValue() as int
	while i < 18
		Spell MajorSpell = MajorSkills[i]
		Spell MinorSpell = MinorSkills[i]
		string skill = skills[i]
		if(PlayerRef.hasSpell(MajorSpell))
			PlayerRef.removeSpell(MajorSpell)
			PlayerRef.setActorValue(skill, baseSkill + majorBoost)
		elseif(PlayerRef.hasSpell(MinorSpell))
			PlayerRef.removeSpell(MinorSpell)
			PlayerRef.setActorValue(skill, baseSkill + minorBoost)
		endIf
		i += 1
	endWhile
endFunction

function vanillaStartGame()
	GLT_Active.setValue(0.0)
	HelgenMapMarker.addToMap(true)
	utility.wait(1.0)
	HelgenDump.enable()
	setStage(15)
	while(getStage() < 16)
		Utility.wait(1.0)
	endWhile
	Fragments.TemporaryHoldingContainer.removeAllItems(HelgenDump)
	Fragments.EquipItemsContainer.removeAllItems(HelgenDump)
	HelgenDump.removeItem(MQ101.ClothesPrisoner)
	HelgenDump.removeItem(MQ101.ClothesPrisonerShoes)
	PlayerRef.moveTo(BackgroundBasePoint)
	Game.forceFirstPerson()
	MQ101.setStage(10)
	Utility.wait(0.1)
	Fragments.FadeToBlackHoldImod.PopTo(Fragments.FadeToBlackBackImod)
	Fragments.FadeToBlackHoldImod.Remove()
endFunction

function galateaStartGame()
	Game.DisablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = true, abLooking = true, abSneaking = true, abMenu = true, abJournalTabs = true)
	setStage(15)
	GLTQ001_FactionMonitors.start()
	SelectedBackground.start()
	while(getStage() < 16)
		Utility.wait(1.0)
	endWhile
	if(SelectedBackground.StartingGearDump.getReference())
		StartingGearDump.forceRefTo(SelectedBackground.StartingGearDump.getReference())
	else
		StartingGearDump.forceRefTo(PlayerRef)
	endIf
	if(!SelectedBackground.providesOwnEquip)
		int items = Fragments.EquipItemsContainer.getNumItems()
		while items > 0
			items -= 1
			Form f = Fragments.EquipItemsContainer.getNthForm(items)
			int count = Fragments.EquipItemsContainer.getItemCount(f)
			Fragments.EquipItemsContainer.removeItem(f, count, true, PlayerRef)
			PlayerRef.equipItem(f, abSilent = true)
		endWhile
	else
		Fragments.EquipItemsContainer.removeAllItems(StartingGearDump.getReference())
	endIf
	Fragments.TemporaryHoldingContainer.removeAllItems(StartingGearDump.getReference())
	Utility.wait(0.1)
	Fragments.FadeToBlackHoldImod.PopTo(Fragments.FadeToBlackBackImod)
	Fragments.FadeToBlackHoldImod.Remove()
	Game.EnablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = true, abLooking = true, abSneaking = true, abMenu = true, abJournalTabs = true)
	helgenCleanup()
	Game.SetInChargen(false, false, false)
endFunction

Actor Property ElenwensHorse Auto
Actor Property Torturer Auto
HelgenHallCollapseScript Property CollapseHallTrigger Auto
ObjectReference Property CollapseHallRef Auto
function helgenCleanup() ; handle everything that would be handled by parts of MQ101 being skipped
	MQ101DA.stop()
	;aliases
	MQ101.Alias_CartHorse1.TryToDisableNoWait()
	MQ101.Alias_CivilianGunnar.trytoDisableNoWait()
	MQ101.Alias_CivilianGunnar.TryToMoveTo(MQ101.HadvarMarker8)
	MQ101.Alias_CivilianIngrid.TryToMoveTo(MQ101.TulliusMarker8)
	MQ101.Alias_CivilianIngrid.TryToDisableNoWait()
	MQ101.Alias_CivilianMatlara.TryToMoveTo(MQ101.TulliusMarker8)
	MQ101.Alias_CivilianMatlara.TryToDisableNoWait()
	MQ101.Alias_CivilianTorolf.TryToDisableNoWait()
	MQ101.Alias_CivilianTorolf.TryToMoveTo(MQ101.TorolfMarker8)
	MQ101.Alias_CivilianTorri.TryToDisableNoWait()
	MQ101.Alias_CivilianTorri.TryToMoveTo(MQ101.TorriMarker8)
	MQ101.Alias_CivilianVilod.TryToMoveTo(MQ101.TulliusMarker8)
	MQ101.Alias_CivilianVilod.TryToDisableNoWait()
	MQ101.Alias_Elenwen.GetActorReference().MoveToMyEditorLocation()
	MQ101.Alias_Hadvar.TryToDisableNoWait()
	MQ101.Alias_Headsman.TryToDisableNoWait()
	MQ101.Alias_HelgenArcher01.TryToDisableNoWait()
	MQ101.Alias_HelgenArcher02.TryToDisableNoWait()
	MQ101.Alias_ImperialSoldier01.TryToMoveTo(MQ101.Guard1Marker8)
	MQ101.Alias_ImperialSoldier01.TryToDisableNoWait()
	MQ101.Alias_ImperialSoldier02.TryToMoveTo(MQ101.Guard2Marker8)
	MQ101.Alias_ImperialSoldier02.TryToDisableNoWait()
	MQ101.Alias_ImperialSoldierFort01.TryToMoveTo(MQ101.FortGuard1Marker8)
	MQ101.Alias_ImperialSoldierFort01.TryToDisableNoWait()
	MQ101.Alias_ImperialSoldierHelgen01.tryToDisableNoWait()
	MQ101.Alias_ImperialSoldierHelgen02.tryToDisableNoWait()
	MQ101.Alias_Justiciar01.trytoDisableNoWait()
	MQ101.Alias_Justiciar02.trytoDisableNoWait()
	MQ101.Alias_Priest.TryToDisableNoWait()
	MQ101.Alias_Prisoner01.TryToDisableNoWait()
	MQ101.Alias_Ralof.GetActorReference().SetOutfit(MQ101.RalofOutfit)
	MQ101.Alias_Ralof.TryToDisableNoWait()
	MQ101.Alias_StormcloakPrisoner01.TryToDisableNoWait()
	MQ101.Alias_StormcloakPrisoner02.TryToMoveTo(MQ101.StormcloakPrisoner2Marker8)
	MQ101.Alias_StormcloakPrisoner02.TryToDisableNoWait()
	MQ101.Alias_StormcloakPrisoner03.TryToMoveTo(MQ101.StormcloakPrisoner3Marker8)
	MQ101.Alias_StormcloakPrisoner03.TryToDisableNoWait()
	MQ101.Alias_StormcloakPrisoner04.TryToMoveTo(MQ101.StormcloakPrisoner1Marker8)
	MQ101.Alias_StormcloakPrisoner04.TryToDisableNoWait()
	MQ101.Alias_TortureRoomImperialSoldier1.TryToDisableNoWait()
	MQ101.Alias_TortureRoomImperialSoldier2.TryToDisableNoWait()
	MQ101.Alias_TortureRoomImperialSoldier3.TryToDisableNoWait()
	MQ101.Alias_TortureRoomStormcloak1.TryToDisableNoWait()
	MQ101.Alias_TortureRoomStormcloak2.TryToDisableNoWait()
	MQ101.Alias_TortureRoomStormcloak3.TryToDisableNoWait()
	MQ101.Alias_Ulfric.GetActorReference().PlayIdle(MQ101.OffSetStop)
	MQ101.Alias_Ulfric.GetActorReference().RemoveItem(MQ101.PrisonerCuffs, 1)
	MQ101.Alias_Ulfric.GetActorReference().UnEquipItem(MQ101.ArmorGag)
	MQ101.Alias_Ulfric.GetActorReference().RemoveItem(MQ101.ArmorGag, 1)
	;hardcoded refs
	MQ101.NorthGate.SetOpen(false)
	MQ101.NorthGate.SetLockLevel(5)
	MQ101.EastGate.SetOpen(false)
	MQ101.EastGate.SetLockLevel(5)
	MQ101.CartPathAmbientMarker.disableNoWait()
	MQ101.CiviliansOutsideHelgenMarker.disableNoWait()
	MQ101.AlduinAttackEnableMarker1.enableNoWait()
	MQ101.CollapsingBridgeAnim.enableNoWait()
	MQ101.BridgeOriginal.disableNoWait()
	MQ101.BridgeDebris.enableNoWait()
	MQ101.ExtHelgenAttackASREF.DisableNoWait()
	MQ101DA.DragonTowerHole.disableNoWait()
	MQ101DA.PostCGMajorClutter.enableNoWait()
	MQ101DA.PostCGMajorFX.enableNoWait()
	MQ101DA.PostCGAreaA.enableNoWait()
	MQ101DA.PostCGAreaAclutter.enableNoWait()
	MQ101DA.PostCGAreaB.enableNoWait()
	MQ101DA.PostCGAreaBClutter.enableNoWait()
	MQ101DA.PostCGAreaC.enableNoWait()
	MQ101DA.PostCGAreaD.enableNoWait()
	MQ101DA.PostCGAreaE.enableNoWait()
	MQ101DA.PostCGAreaEClutter.enableNoWait()
	ElenwensHorse.disableNoWait()
	Torturer.disableNoWait()
	Weather.ReleaseOverride()
	
	CollapseHallRef.disable()
	CollapseHallTrigger.goToState("done")
	HelgenPostChargenMarker.enable()
	
	;scenes
	MQ101.KeepIntroSceneA.Stop()
	MQ101.KeepScene2A.Stop()
	MQ101.KeepScene4A.Stop()
	MQ101.KeepScene5A.Stop()
	MQ101.KeepIntroSceneB.Stop()
	MQ101.KeepScene2B.Stop()
	MQ101.KeepScene4B.Stop()
	MQ101.KeepScene5B.Stop()
	MQ101.setStage(1000)
	
	;next quest
	if(DragonsExist.getValue() > 0.0)
		GLTQ002.start()
	endIf
	MirmulnirHandler.start()
endFunction

