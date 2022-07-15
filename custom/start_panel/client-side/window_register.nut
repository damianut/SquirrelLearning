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
local buttonRegisterExitInfo = GUI.Button(anx(500), -any(50), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "Wyjdü z gry", windowRegister)

local windowFeedback = GUI.Window(4096 - anx(250), 4096 - any(325), anx(500), any(300), "MENU_INGAME.TGA", null, true)
local buttonRegisterStatusInfoClose = GUI.Button(anx(450), 0, anx(50), any(25), "INV_SLOT_FOCUS.TGA", "X", windowFeedback)
local drawRegisterStatusInfo = GUI.Draw(anx(90), any(120), "", windowFeedback)

local registrationAccountClient = null;

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	windowRegister.setVisible(true)
	buttonRegisterExitInfo.setVisible(false)
	registerLoginInput.setDisabled(false)
	registerPasswordInput.setDisabled(false)
	windowFeedback.setVisible(false)
})

addEventHandler("GUI.onClick", function(self)
{
	switch (self)
	{
		case buttonRegisterClose:
			exitGame()
			break
			
		case buttonRegisterDo:
			registrationAccountClient = RegisterAccountClient(registerLoginInput, registerPasswordInput)
			registrationAccountClient.processRegistration()
			break
		
		case buttonRegisterStatusInfoClose:
			if (windowFeedback.getVisible())
			{
				drawRegisterStatusInfo.setText("")
				windowFeedback.setVisible(false)
				windowRegister.setVisible(true);
			}
			break
	}
})

addEventHandler("GUI.onMouseIn", function(self)
{
	switch (self)
	{
		case buttonRegisterDo:
			self.setColor(255, 0, 0)
			break
		
		case buttonRegisterClose:
			self.setColor(255, 0, 0)
			buttonRegisterExitInfo.setVisible(true)
			break
			
		case buttonRegisterStatusInfoClose:
			if (buttonRegisterStatusInfoClose.getVisible())
			{
				self.setColor(255, 0, 0)
			}
			break;
	}
})

addEventHandler("GUI.onMouseOut", function(self)
{
	switch (self)
	{
		case buttonRegisterDo:
			self.setColor(255, 255, 255)
			break
		
		case buttonRegisterClose:
			self.setColor(255, 255, 255)
			buttonRegisterExitInfo.setVisible(false)
			break
			
		case buttonRegisterStatusInfoClose:
			if (buttonRegisterStatusInfoClose.getVisible())
			{
				self.setColor(255, 255, 255)
			}
			break;
	}
})
//Get and display data from server about registration request.
addEventHandler("onPacket", function(packet) {
	Chat.print(0, 255, 0, "again");
	local packetId = packet.readUInt16();
	Chat.print(0, 255, 0, "agains");
	switch (packetId)
	{
		case PacketsIds.REGISTER_PWDLOGIN_TO_CLIENT_RESPONSE:
			Chat.print(0, 255, 0, "againss");
			drawRegisterStatusInfo.setText(packet.readString());
			windowRegister.setVisible(false);
			windowFeedback.setVisible(true);
			buttonRegisterStatusInfoClose.setVisible(true);
			break;
	}
})