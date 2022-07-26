// -------------------- BACKGROUND IMAGE -------------------- //
local bgImage = GUI.Texture(0, 0, 8192, 8192, "DACH.TGA")

// -------------------- WINDOWS -------------------- //
// Register window
local windowRegister = GUI.Window(4096 - 1499, 4096 - 3467, 2999, 3200, "MENU_INGAME.TGA", null, true);
local buttonRegisterLeftUpperCorner = GUI.Button(0, 0, 300, 533, "INV_SLOT_FOCUS.TGA", "", windowRegister);
local buttonRegisterUpperInfo = GUI.Button(300, 0, 2399, 533, "INV_SLOT_FOCUS.TGA", "REJESTRACJA", windowRegister);
local buttonRegisterExit = GUI.Button(2699, 0, 300, 533, "INV_SLOT_FOCUS.TGA", "X", windowRegister);
local buttonRegisterLoginInfo = GUI.Button(0, 533, 900, 1067, "INV_SLOT_FOCUS.TGA", "LOGIN", windowRegister);
local registerLoginInput = GUI.Input(900, 533, 2087, 1045, "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Text, Align.Center, ">               ", 2, windowRegister);
local buttonRegisterPwdInfo = GUI.Button(0, 1600, 900, 1067, "INV_SLOT_FOCUS.TGA", "HAS£O", windowRegister);
local registerPasswordInput = GUI.Input(900, 1600, 2087, 1045, "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Password, Align.Center, ">               ", 2, windowRegister);
local buttonRegisterLeftBottomCorner = GUI.Button(0, 2667, 900, 533, "INV_SLOT_FOCUS.TGA", "", windowRegister);
local buttonRegisterDo = GUI.Button(900, 2667, 2099, 533, "INV_SLOT_FOCUS.TGA", "ZAREJESTRUJ", windowRegister);
local buttonRegisterExitInfo = GUI.Button(2999, -533, 900, 533, "INV_SLOT_FOCUS.TGA", "WyjdŸ z gry", windowRegister);

// Login window
local windowLogin = GUI.Window(4096 - 1499, 4096 + 267, 2999, 3200, "MENU_INGAME.TGA", null, true);
local buttonLoginLeftUpperCorner = GUI.Button(0, 0, 300, 533, "INV_SLOT_FOCUS.TGA", "", windowLogin);
local buttonLoginUpperInfo = GUI.Button(300, 0, 2399, 533, "INV_SLOT_FOCUS.TGA", "LOGOWANIE", windowLogin);
local buttonLoginExit = GUI.Button(2699, 0, 300, 533, "INV_SLOT_FOCUS.TGA", "X", windowLogin);
local buttonLoginLoginInfo = GUI.Button(0, 533, 900, 1067, "INV_SLOT_FOCUS.TGA", "LOGIN", windowLogin);
local loginLoginInput = GUI.Input(900, 533, 2087, 1045, "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Text, Align.Center, ">               ", 2, windowLogin);
local buttonLoginPwdInfo = GUI.Button(0, 1600, 900, 1067, "INV_SLOT_FOCUS.TGA", "HAS£O", windowLogin);
local loginPasswordInput = GUI.Input(900, 1600, 2087, 1045, "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Password, Align.Center, ">               ", 2, windowLogin);
local buttonLoginLeftBottomCorner = GUI.Button(0, 2667, 900, 533, "INV_SLOT_FOCUS.TGA", "", windowLogin);
local buttonLoginDo = GUI.Button(900, 2667, 2099, 533, "INV_SLOT_FOCUS.TGA", "ZALOGUJ", windowLogin);
local buttonLoginExitInfo = GUI.Button(2999, -533, 900, 533, "INV_SLOT_FOCUS.TGA", "WyjdŸ z gry", windowLogin);

// Feedback window
// It's used for displaying informations about user's requests (registering). 
local windowRegisterFeedback = GUI.Window(4096 - 1499, 4096 - 3467, 2999, 3200, "MENU_INGAME.TGA", null, true);
local buttonRegisterWindowFeedbackClose = GUI.Button(2699, 0, 300, any(25), "INV_SLOT_FOCUS.TGA", "X", windowRegisterFeedback);
local drawRegisterFeedback = GUI.Draw(anx(30), any(120), "", windowRegisterFeedback);
// It's used for displaying informations about user's requests (login). 
local windowLoginFeedback = GUI.Window(4096 - 1499, 4096 + any(25), 2999, 3200, "MENU_INGAME.TGA", null, true);
local buttonLoginWindowFeedbackClose = GUI.Button(2699, 0, 300, any(25), "INV_SLOT_FOCUS.TGA", "X", windowLoginFeedback);
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
    // c.d. Removing messages about joining the server and disable controls.
	"onInitWindow" : function () {
        clearMultiplayerMessages(); // Removing messages about joining the server.
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
                windowLogin.setVisible(false);
                if (windowRegister.getVisible()) {
                    windowRegister.setVisible(false);
                }
                if (windowLoginFeedback.getVisible()) {
                    windowLoginFeedback.setVisible(false);
                }
                if (windowRegisterFeedback.getVisible()) {
                    windowRegisterFeedback.setVisible(false);
                }
                
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

// ---------- OLD NOTES ---------- //
// 1. Previously, in GUI elements's definitions I used converting pixels to virtuals,
// but panel looks bad on resolutions different than 1366x768
// So I count virtuals from pixels on 1366x768 screen, and then I use virtuals directly in GUI elements's definitions.
//
// Pixels to virtuals on 1366x768 resolution screen.
// anx(250) = 1499
// anx(500) = 2999
// anx(50) = 300
// anx(450) = 2699
// anx(150) = 900
// anx(348) = 2087
// anx(350) = 2099
// anx(400) = 2399

// any(325) = 3467
// any(300) = 3200
// any(50) = 533
// any(100) = 1067
// any(98) = 1045
// any(250) = 2667
// any(150) = 1600
// any(25) = 267