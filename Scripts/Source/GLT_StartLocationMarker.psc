Scriptname GLT_StartLocationMarker extends ObjectReference  

GLTQ01 Property Chargen Auto
Location property thisLocation auto
String property displayedName auto

Event OnInit()
	registerForModEvent("GLT_LocationSelect", "OnStartSelected")
	if(displayedName)
		setDisplayName(displayedName)
	elseif(thisLocation)
		displayedName = thisLocation.getName()
		setDisplayName(displayedName)
	endIf
endEvent

Event OnStartSelected(Form selection)
	GLT_BackgroundQuest background = selection as GLT_BackgroundQuest
	bool isValid = background.filter(thisLocation)
	bool disabled = isDisabled()
	if(isValid && disabled)
		enable()
	elseif(!isValid && !disabled)
		disable()
	endIf
endEvent

Event OnActivate(ObjectReference ref)
	Chargen.selectLocationMarker(self)
endEvent

Location function setLocation(Location loc)
	Location temp = thisLocation
	thisLocation = loc
	displayedName = thisLocation.getName()
	setDisplayName(displayedName)
	return temp
endFunction