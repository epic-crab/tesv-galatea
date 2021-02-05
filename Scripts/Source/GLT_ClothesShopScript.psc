Scriptname GLT_ClothesShopScript extends ObjectReference  

ObjectReference Property Shop Auto
ObjectReference Property Wardrobe Auto

auto state main
	Event OnActivate(ObjectReference actronaut)
		Shop.activate(actronaut)
		Wardrobe.playGamebryoAnimation("Open", true)
		RegisterForMenu("Crafting Menu")
	endEvent

	Event OnMenuClose(string menuName)
		Wardrobe.playGamebryoAnimation("Close", true)
		goToState("animating")
	endEvent
endState

state animating
	Event OnBeginState()
		Utility.wait(0.5)
		goToState("main")
	endEvent
endState