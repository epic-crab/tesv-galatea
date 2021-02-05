Scriptname GLT_LibraryController extends ObjectReference  

EffectShader Property Disintegrate Auto
EffectShader Property UnDisintegrate Auto
ObjectReference Property libraryCollision Auto
ObjectReference Property libraryDesk Auto
ObjectReference Property libaryEnableParent Auto
ObjectReference Property leaveForward Auto
ObjectReference Property leaveBack Auto
GLT_LibraryGateScript Property gate Auto

float fx
float fy
float fz
float bx
float by
float bz

Event OnLoad()
	fx = leaveForward.getPositionX()
	fy = leaveForward.getPositionY()
	fz = leaveForward.getPositionZ()
	bx = leaveBack.getPositionX()
	by = leaveBack.getPositionY()
	bz = leaveBack.getPositionZ()
	leaveForward.setPosition(0.0, 0.0, 0.0)
	leaveBack.setPosition(0.0, 0.0, 0.0)
	Disintegrate.play(self)
	Disintegrate.play(libraryDesk)
endEvent

function appear()
	Disintegrate.stop(self)
	UnDisintegrate.play(self, 0.6)
	libraryCollision.enable(false)
	Disintegrate.stop(libraryDesk)
	UnDisintegrate.play(libraryDesk, 0.6)
	libaryEnableParent.enable()
	leaveForward.setPosition(fx, fy, fz)
	leaveBack.setPosition(bx, by, bz)
endFunction

function disappear()
	leaveForward.setPosition(0.0, 0.0, 0.0)
	leaveBack.setPosition(0.0, 0.0, 0.0)
	Disintegrate.play(self)
	Disintegrate.play(libraryDesk)
	libraryCollision.disable(false)
	libaryEnableParent.disable()
	gate.enable()
	gate.setOpen(false)
endFunction