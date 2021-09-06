Scriptname GLT_FactionMonitors extends Quest  

bool property playerHasCompanionsPointer = false auto hidden
bool property playerJoinedCompanions = false auto hidden
bool property playerHasThievesGuildPointer = false auto hidden
bool property playerJoinedThievesGuild = false auto hidden
bool property playerHasCollegePointer = false auto hidden
bool property playerJoinedCollege = false auto hidden
bool property playerHasDarkBrotherhoodPointer = false auto hidden
bool property playerJoinedDarkBrotherhood = false auto hidden

Quest property QuestToAlert Auto hidden
int property CompanionsPointerStageToSet = -1 Auto hidden
int property CompanionsJoinedStageToSet = -1 Auto hidden
int property ThievesGuildPointerStageToSet = -1 Auto hidden
int property ThievesGuildJoinedStageToSet = -1 Auto hidden
int property CollegePointerStageToSet = -1 Auto hidden
int property CollegeJoinedStageToSet = -1 Auto hidden
int property DarkBrotherhoodPointerStageToSet = -1 Auto hidden
int property DarkBrotherhoodJoinedStageToSet = -1 Auto hidden

bool property HuldaTriggersCompanionsPointer = true auto

Quest Property CompanionsMiscObjective Auto
Quest Property C00 Auto
Quest Property TG00 Auto
Quest Property TG02 Auto
Quest Property MG01Pointer Auto
Quest Property MG01 Auto
Quest Property DB02 Auto

function registerFactionCallbackStages(Quest target, int companionsPointerStage = -1, int companionsJoinedStage = -1, int thievesGuildPointerStage = -1, int thievesGuildJoinedStage = -1, int collegePointerStage = -1, int collegeJoinedStage = -1, int darkBrotherhoodPointerStage = -1, int darkBrotherhoodJoinedStage = -1)
	registerForMenu("Dialogue Menu")
	QuestToAlert = target
	CompanionsPointerStageToSet = companionsPointerStage
	CompanionsJoinedStageToSet = companionsJoinedStage
	ThievesGuildPointerStageToSet = thievesGuildPointerStage
	ThievesGuildJoinedStageToSet = thievesGuildJoinedStage
	CollegePointerStageToSet = collegePointerStage
	CollegeJoinedStageToSet = collegeJoinedStage
	DarkBrotherhoodPointerStageToSet = darkBrotherhoodPointerStage
	DarkBrotherhoodJoinedStageToSet = darkBrotherhoodJoinedStage
endFunction

Event OnMenuClose(String MenuName)
	;companions
	if(!playerHasCompanionsPointer && CompanionsMiscObjective.isStageDone(10))
		playerHasCompanionsPointer = true
		if(CompanionsPointerStageToSet > 0 && QuestToAlert.isRunning())
			QuestToAlert.setStage(CompanionsPointerStageToSet)
		endIf
	endIf
	if(!playerJoinedCompanions && C00.isStageDone(20))
		playerJoinedCompanions = true
		if(CompanionsJoinedStageToSet > 0 && QuestToAlert.isRunning())
			QuestToAlert.setStage(CompanionsJoinedStageToSet)
		endIf
	endIf
	;thieves guild
	if(!playerHasThievesGuildPointer && TG00.isStageDone(200))
		playerHasThievesGuildPointer = true
		if(ThievesGuildPointerStageToSet > 0 && QuestToAlert.isRunning())
			QuestToAlert.setStage(ThievesGuildPointerStageToSet)
		endIf
	endIf
	if(!playerJoinedThievesGuild && TG02.isStageDone(10))
		playerJoinedThievesGuild = true
		if(ThievesGuildJoinedStageToSet > 0 && QuestToAlert.isRunning())
			QuestToAlert.setStage(ThievesGuildJoinedStageToSet)
		endIf
	endIf
	;college of winterhold
	if(!playerHasCollegePointer && MG01Pointer.isStageDone(10))
		playerHasCollegePointer = true
		if(CollegePointerStageToSet > 0 && QuestToAlert.isRunning())
			QuestToAlert.setStage(CollegePointerStageToSet)
		endIf
	endIf
	if(!playerJoinedCollege && MG01.isStageDone(30))
		playerJoinedCollege = true
		if(CollegeJoinedStageToSet > 0 && QuestToAlert.isRunning())
			QuestToAlert.setStage(CollegeJoinedStageToSet)
		endIf
	endIf
	;dark brotherhood
	if(!playerHasDarkBrotherhoodPointer && DB02.isStageDone(40))
		playerHasDarkBrotherhoodPointer = true
		if(DarkBrotherhoodPointerStageToSet > 0 && QuestToAlert.isRunning())
			QuestToAlert.setStage(DarkBrotherhoodPointerStageToSet)
		endIf
	endIf
	if(!playerJoinedDarkBrotherhood && DB02.isStageDone(200))
		playerJoinedDarkBrotherhood = true
		if(DarkBrotherhoodJoinedStageToSet > 0 && QuestToAlert.isRunning())
			QuestToAlert.setStage(DarkBrotherhoodJoinedStageToSet)
		endIf
	endIf
	;check if done
	if( (playerHasCompanionsPointer || CompanionsPointerStageToSet < 0) && \
		(playerJoinedCompanions || CompanionsJoinedStageToSet < 0) && \
		(playerHasThievesGuildPointer || ThievesGuildPointerStageToSet < 0) && \
		(playerJoinedThievesGuild || ThievesGuildJoinedStageToSet < 0) && \
		(playerHasCollegePointer || CollegePointerStageToSet < 0) && \
		(playerJoinedCollege || CollegeJoinedStageToSet < 0) && \
		(playerHasDarkBrotherhoodPointer || DarkBrotherhoodPointerStageToSet < 0) && \
		(playerJoinedDarkBrotherhood || DarkBrotherhoodJoinedStageToSet < 0))
		unregisterForAllMenus()
	endIf
endEvent