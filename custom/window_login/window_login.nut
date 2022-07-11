local window = GUI.Window(4096 - anx(250), 4096 + any(25), anx(500), any(300), "MENU_INGAME.TGA", null, true)

local buttonLeftUpperCorner = GUI.Button(0, 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "", window)
local buttonUpperInfo = GUI.Button(anx(50), 0, anx(400), any(50), "INV_SLOT_FOCUS.TGA", "LOGOWANIE", window)
local buttonClose = GUI.Button(anx(450), 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "X", window)
local buttonLoginInfo = GUI.Button(0, any(50), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "LOGIN", window)
local loginInput = GUI.Input(anx(150), any(50), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Text, Align.Center, ">               ", 2, window)
local buttonPwdInfo = GUI.Button(0, any(150), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "HAS£O", window)
local passwordInput = GUI.Input(anx(150), any(150), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Password, Align.Center, ">               ", 2, window)
local buttonLeftBottomCorner = GUI.Button(0, any(250), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "", window)
local buttonLoginDo = GUI.Button(anx(150), any(250), anx(350), any(50), "INV_SLOT_FOCUS.TGA", "ZALOGUJ", window)
local buttonExitInfo = GUI.Button(anx(500), -any(50), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "Wyjdü z gry", window)

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	window.setVisible(true)
	buttonExitInfo.setVisible(false)
	loginInput.setDisabled(false)
	passwordInput.setDisabled(false)
})

addEventHandler("GUI.onClick", function(self)
{
	switch (self)
	{
		case buttonClose:
			exitGame()
				break
	}
})

addEventHandler("GUI.onMouseIn", function(self)
{
	if (!(self instanceof GUI.Button))
		return
	
	if (self == buttonLoginDo)
	{
		self.setColor(255, 0, 0)
	} else if (self == buttonClose)
	{
		self.setColor(255, 0, 0)
		buttonExitInfo.setVisible(true)
	}
})

addEventHandler("GUI.onMouseOut", function(self)
{
	if (!(self instanceof GUI.Button))
		return
	
	if (self == buttonLoginDo)
	{
		self.setColor(255, 255, 255)
	} else if (self == buttonClose)
	{
		self.setColor(255, 255, 255)
		buttonExitInfo.setVisible(false)
	}
})
