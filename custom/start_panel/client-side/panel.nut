// -------------------- BACKGROUND IMAGE -------------------- //
local bgImage = GUI.Texture(0, 0, 8192, 8192, "DACH.TGA")

// -------------------- WINDOWS -------------------- //
// Register window
local windowRegister = GUI.Window(4096 - anx(250), 4096 - any(325), anx(500), any(300), "MENU_INGAME.TGA", null, true);
local buttonRegisterLeftUpperCorner = GUI.Button(0, 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "", windowRegister);
local buttonRegisterUpperInfo = GUI.Button(anx(50), 0, anx(400), any(50), "INV_SLOT_FOCUS.TGA", "REJESTRACJA", windowRegister);
local buttonRegisterExit = GUI.Button(anx(450), 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "X", windowRegister);
local buttonRegisterLoginInfo = GUI.Button(0, any(50), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "LOGIN", windowRegister);
local registerLoginInput = GUI.Input(anx(150), any(50), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Text, Align.Center, ">               ", 2, windowRegister);
local buttonRegisterPwdInfo = GUI.Button(0, any(150), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "HAS£O", windowRegister);
local registerPasswordInput = GUI.Input(anx(150), any(150), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Password, Align.Center, ">               ", 2, windowRegister);
local buttonRegisterLeftBottomCorner = GUI.Button(0, any(250), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "", windowRegister);
local buttonRegisterDo = GUI.Button(anx(150), any(250), anx(350), any(50), "INV_SLOT_FOCUS.TGA", "ZAREJESTRUJ", windowRegister);
local buttonRegisterExitInfo = GUI.Button(anx(500), -any(50), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "WyjdŸ z gry", windowRegister);

// Login window
local windowLogin = GUI.Window(4096 - anx(250), 4096 + any(25), anx(500), any(300), "MENU_INGAME.TGA", null, true);
local buttonLoginLeftUpperCorner = GUI.Button(0, 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "", windowLogin);
local buttonLoginUpperInfo = GUI.Button(anx(50), 0, anx(400), any(50), "INV_SLOT_FOCUS.TGA", "LOGOWANIE", windowLogin);
local buttonLoginExit = GUI.Button(anx(450), 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "X", windowLogin);
local buttonLoginLoginInfo = GUI.Button(0, any(50), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "LOGIN", windowLogin);
local loginLoginInput = GUI.Input(anx(150), any(50), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Text, Align.Center, ">               ", 2, windowLogin);
local buttonLoginPwdInfo = GUI.Button(0, any(150), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "HAS£O", windowLogin);
local loginPasswordInput = GUI.Input(anx(150), any(150), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Password, Align.Center, ">               ", 2, windowLogin);
local buttonLoginLeftBottomCorner = GUI.Button(0, any(250), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "", windowLogin);
local buttonLoginDo = GUI.Button(anx(150), any(250), anx(350), any(50), "INV_SLOT_FOCUS.TGA", "ZALOGUJ", windowLogin);
local buttonLoginExitInfo = GUI.Button(anx(500), -any(50), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "WyjdŸ z gry", windowLogin);

// Feedback window
// It's used for displaying informations about user's requests (registering). 
local windowRegisterFeedback = GUI.Window(4096 - anx(250), 4096 - any(325), anx(500), any(300), "MENU_INGAME.TGA", null, true);
local buttonRegisterWindowFeedbackClose = GUI.Button(anx(450), 0, anx(50), any(25), "INV_SLOT_FOCUS.TGA", "X", windowRegisterFeedback);
local drawRegisterFeedback = GUI.Draw(anx(30), any(120), "", windowRegisterFeedback);
// It's used for displaying informations about user's requests (login). 
local windowLoginFeedback = GUI.Window(4096 - anx(250), 4096 + any(25), anx(500), any(300), "MENU_INGAME.TGA", null, true);
local buttonLoginWindowFeedbackClose = GUI.Button(anx(450), 0, anx(50), any(25), "INV_SLOT_FOCUS.TGA", "X", windowLoginFeedback);
local drawLoginFeedback = GUI.Draw(anx(30), any(120), "", windowLoginFeedback);

// -------------------- DISPLAY/HIDE BACKGROUND IMAGE -------------------- //
function displayBgImage () {
    bgImage.setVisible(true);
    bgImage.setScaling(true);
    enableHud (HUD_HEALTH_BAR, false); // Hide bar, that covering background.
}
function hideBgImage () {
    bgImage.setVisible(false);
    enableHud (HUD_HEALTH_BAR, true);
}
addEventHandler("onInit", displayBgImage);

// --------------------  PROCESS REGISTER REQUEST -------------------- //
local RegPPCInst = ProcessPanelClient (registerLoginInput, registerPasswordInput);

// -------------------- PROCESS LOGIN REQUEST -------------------- //
local LogPPCInst = ProcessPanelClient (loginLoginInput, loginPasswordInput);

// -------------------- INTERACTING WITH REGISTER WINDOW -------------------- //
function displayWindowRegisterFeedback (msg) {
    drawRegisterFeedback.setText(msg);
    windowRegister.setVisible(false);
    windowRegisterFeedback.setVisible(true);
    buttonRegisterWindowFeedbackClose.setVisible(true);
}

function hideWindowRegisterFeedback () {
    drawRegisterFeedback.setText("");
    windowRegisterFeedback.setVisible(false);
    windowRegister.setVisible(true);
    buttonRegisterExitInfo.setVisible(false);
    // Reset inputs
    registerLoginInput.setText("");
	registerPasswordInput.setText("");
}

// This table contains function for 5 event handlers.
local interactingWindowRegister = {
	// Displaying register window after "onInit" event. "Initialize" table for handling requests from register panel.
	"onInitWindow" : function () {
        disableControls(true);
		setCursorVisible(true);
		windowRegister.setVisible(true);
		// This window describes the operation of the button "X". It should be visible only after hovering the cursor over the button.
		buttonRegisterExitInfo.setVisible(false);
		registerLoginInput.setDisabled(false);
		registerPasswordInput.setDisabled(false);
		windowRegisterFeedback.setVisible(false);
	},

	// Handling clicking on register window.
	"onClickWindow" : function (self) {
		switch (self) {
			case buttonRegisterExit:
				exitGame();
				break;
				
			case buttonRegisterDo:
                // TEST
                // END TEST
				RegPPCInst.refreshInputsData();
				if (RegPPCInst.checkLoginPwdRequirements()) {
					RegPPCInst.sendRequestToServer("register");
				} else {
					displayWindowRegisterFeedback (RegPPCInst.getFeedbackMsg());
				}
				break;
			
			case buttonRegisterWindowFeedbackClose:
				if (windowRegisterFeedback.getVisible()) {
					hideWindowRegisterFeedback();
				}
				break;
		}
	},

	// Handling driving the mouse in register window.
	"onMouseInWindow" : function (self) {
		switch (self) {
            case buttonRegisterExit:
				self.setColor(255, 0, 0);
				buttonRegisterExitInfo.setVisible(true);
				break;
                
			case buttonRegisterDo:
				self.setColor(255, 0, 0);
				break;
				
			case buttonRegisterWindowFeedbackClose:
				if (self.getVisible()) {
					self.setColor(255, 0, 0);
				}
				break;
		}
	},

	// Handling driving the mouse out of register window.
	"onMouseOutWindow" : function (self) {
		switch (self) {
            case buttonRegisterExit:
				self.setColor(255, 255, 255);
				buttonRegisterExitInfo.setVisible(false);
				break;
                
			case buttonRegisterDo:
				self.setColor(255, 255, 255);
				break;
				
			case buttonRegisterWindowFeedbackClose:
				if (self.getVisible()) {
					self.setColor(255, 255, 255);
				}
				break;
		}
	},

	//Display data about registration request.
	"onPacketResponse" : function (packet) {
		local packetId = packet.readUInt16();
		switch (packetId) {
			case PacketsIds.REGISTER_ACC_RESPONSE_TO_CLIENT:
				displayWindowRegisterFeedback(packet.readString());
				break;
		}
	}
};

// Attach event handlers.
addEventHandler("onInit", interactingWindowRegister.onInitWindow);
addEventHandler("GUI.onClick", interactingWindowRegister.onClickWindow);
addEventHandler("GUI.onMouseIn", interactingWindowRegister.onMouseInWindow);
addEventHandler("GUI.onMouseOut", interactingWindowRegister.onMouseOutWindow);
addEventHandler("onPacket", interactingWindowRegister.onPacketResponse);

// -------------------- INTERACTING WITH LOGIN WINDOW -------------------- //
function displayWindowLoginFeedback (msg) {
    drawLoginFeedback.setText(msg);
    windowLogin.setVisible(false);
    windowLoginFeedback.setVisible(true);
    buttonLoginWindowFeedbackClose.setVisible(true);
    // Reset inputs
    loginLoginInput.setText("");
	loginPasswordInput.setText("");
}

function hideWindowLoginFeedback() {
    drawLoginFeedback.setText("");
    windowLoginFeedback.setVisible(false);
    windowLogin.setVisible(true);
    buttonLoginExitInfo.setVisible(false);
}

// This table contains function for 5 event handlers.
local interactingWindowLogin = {    
	// Displaying login window after "onInit" event.
	"onInitWindow" : function () {
        windowLogin.setVisible(true);
		loginLoginInput.setDisabled(false);
		loginPasswordInput.setVisible(true);
		//Q: Czemu trzeba ustawiæ akurat ten input osobno na "visible"; a ¿eby by³o widaæ resztê, wystarczy³o ustawiæ na "visible" 'window'?
		//Q c.d.: Bo by³ to ostatni zdefiniowany input?
		loginPasswordInput.setDisabled(false);
		buttonLoginExitInfo.setVisible(false);
        windowLoginFeedback.setVisible(false);
	},

	// Handling clicking on login window.
	"onClickWindow" : function (self) {
		switch (self) {
			case buttonLoginExit:
				exitGame();
				break;
            case buttonLoginDo:
				LogPPCInst.refreshInputsData();
                // If login and password don't meet requirements, then it's impossible, that given login and password exist in database.
                // So if below checking return false, then it's mean, that user with given login and password doesn't exist.
				if (LogPPCInst.checkLoginPwdRequirements()) {
					LogPPCInst.sendRequestToServer("login");
				} else {
					displayWindowLoginFeedback (LogPPCInst.getFeedbackMsg());
				}
				break;
			
			case buttonLoginWindowFeedbackClose:
				if (windowLoginFeedback.getVisible()) {
					hideWindowLoginFeedback();
				}
				break;
		}
	},

	// Handling driving the mouse in login window.
	"onMouseInWindow" : function (self) {
		switch (self) {
            case buttonLoginExit:
				self.setColor(255, 0, 0);
				buttonLoginExitInfo.setVisible(true);
				break;
                
			case buttonLoginDo:
				self.setColor(255, 0, 0);
				break;
				
			case buttonLoginWindowFeedbackClose:
				if (self.getVisible()) {
					self.setColor(255, 0, 0);
				}
				break;
		}
	},

	// Handling driving the mouse out of login window.
	"onMouseOutWindow" : function (self) {
		switch (self) {
            case buttonLoginExit:
				self.setColor(255, 255, 255);
				buttonLoginExitInfo.setVisible(false);
				break;
                
			case buttonLoginDo:
				self.setColor(255, 255, 255);
				break;
				
			case buttonLoginWindowFeedbackClose:
				if (self.getVisible()) {
					self.setColor(255, 255, 255);
				}
				break;
		}
	}
    
    //Display data about login request.
	"onPacketResponse" : function (packet) {
		local packetId = packet.readUInt16();
		switch (packetId) {
			case PacketsIds.LOGIN_ACC_RESPONSE_TO_CLIENT:
				displayWindowLoginFeedback(packet.readString());
				break;
            case PacketsIds.LOGIN_ACC_DO:
                hideBgImage();
                disableControls(false);
                setCursorVisible(false);
                windowRegister.setVisible(false);
                windowLogin.setVisible(false);
                Chat.setVisible(true);
                break;
		}
	}
};

// Attach event handlers.
addEventHandler("onInit", interactingWindowLogin.onInitWindow);
addEventHandler("GUI.onClick", interactingWindowLogin.onClickWindow);
addEventHandler("GUI.onMouseIn", interactingWindowLogin.onMouseInWindow);
addEventHandler("GUI.onMouseOut", interactingWindowLogin.onMouseOutWindow);
addEventHandler("onPacket", interactingWindowLogin.onPacketResponse);