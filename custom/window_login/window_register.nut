local windowRegister = GUI.Window(4096 - anx(250), 4096 - any(325), anx(500), any(300), "MENU_INGAME.TGA", null, true)

local buttonRegisterLeftUpperCorner = GUI.Button(0, 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "", windowRegister)
local buttonRegisterUpperInfo = GUI.Button(anx(50), 0, anx(400), any(50), "INV_SLOT_FOCUS.TGA", "REJESTRACJA", windowRegister)
local buttonRegisterClose = GUI.Button(anx(450), 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "X", windowRegister)
local buttonRegisterLoginInfo = GUI.Button(0, any(50), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "LOGIN", windowRegister)
local registerLoginInput = GUI.Input(anx(150), any(50), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Text, Align.Center, ">               ", 2, windowRegister)
local buttonRegisterPwdInfo = GUI.Button(0, any(150), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "HAS£O", windowRegister)
local registerPasswordInput = GUI.Input(anx(150), any(150), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Password, Align.Center, ">               ", 2, windowRegister)
local buttonRegisterLeftBottomCorner = GUI.Button(0, any(250), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "", windowRegister)
local buttonRegisterDo = GUI.Button(anx(150), any(250), anx(350), any(50), "INV_SLOT_FOCUS.TGA", "ZAREJESTRUJ", windowRegister)
local buttonRegisterExitInfo = GUI.Button(anx(500), -any(75), anx(100), any(75), "INV_SLOT_FOCUS.TGA", "Wyjdü z gry", windowRegister)

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	windowRegister.setVisible(true)
	registerLoginInput.setDisabled(false)
	registerPasswordInput.setDisabled(false)
})

addEventHandler("GUI.onClick", function(self)
{
	switch (self)
	{
		case buttonRegisterClose:
			exitGame()
				break
	}
})

addEventHandler("GUI.onMouseIn", function(self)
{
	if (!(self instanceof GUI.Button))
		return
	
	if (
		(self == buttonRegisterClose) ||
		(self == buttonRegisterDo)
	)
		self.setColor(255, 0, 0)
		
	if (self == buttonRegisterExitInfo)
		self.setVisible(true)
})

addEventHandler("GUI.onMouseOut", function(self)
{
	if (!(self instanceof GUI.Button))
		return
	
	if (
		(self == buttonRegisterClose) ||
		(self == buttonRegisterDo)
	)
		self.setColor(255, 255, 255)
		
	if (self == buttonRegisterExitInfo)
		self.setVisible(false)
})
