// -------------------- WINDOWS -------------------- //
// Register window
local windowRegister = GUI.Window(4096 - anx(250), 4096 - any(325), anx(500), any(300), "MENU_INGAME.TGA", null, true);
local buttonRegisterLeftUpperCorner = GUI.Button(0, 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "", windowRegister);
local buttonRegisterUpperInfo = GUI.Button(anx(50), 0, anx(400), any(50), "INV_SLOT_FOCUS.TGA", "REJESTRACJA", windowRegister);
local buttonRegisterClose = GUI.Button(anx(450), 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "X", windowRegister);
local buttonRegisterLoginInfo = GUI.Button(0, any(50), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "LOGIN", windowRegister);
local registerLoginInput = GUI.Input(anx(150), any(50), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Text, Align.Center, ">               ", 2, windowRegister);
local buttonRegisterPwdInfo = GUI.Button(0, any(150), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "HAS£O", windowRegister);
local registerPasswordInput = GUI.Input(anx(150), any(150), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Password, Align.Center, ">               ", 2, windowRegister);
local buttonRegisterLeftBottomCorner = GUI.Button(0, any(250), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "", windowRegister);
local buttonRegisterDo = GUI.Button(anx(150), any(250), anx(350), any(50), "INV_SLOT_FOCUS.TGA", "ZAREJESTRUJ", windowRegister);
local buttonRegisterExitInfo = GUI.Button(anx(500), -any(50), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "WyjdŸ z gry", windowRegister);

// Login window
local windowLogin = GUI.Window(4096 - anx(250), 4096 + any(25), anx(500), any(300), "MENU_INGAME.TGA", null, true);
local buttonLeftUpperCorner = GUI.Button(0, 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "", windowLogin);
local buttonUpperInfo = GUI.Button(anx(50), 0, anx(400), any(50), "INV_SLOT_FOCUS.TGA", "LOGOWANIE", windowLogin);
local buttonClose = GUI.Button(anx(450), 0, anx(50), any(50), "INV_SLOT_FOCUS.TGA", "X", windowLogin);
local buttonLoginInfo = GUI.Button(0, any(50), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "LOGIN", windowLogin);
local loginInput = GUI.Input(anx(150), any(50), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Text, Align.Center, ">               ", 2, windowLogin);
local buttonPwdInfo = GUI.Button(0, any(150), anx(150), any(100), "INV_SLOT_FOCUS.TGA", "HAS£O", windowLogin);
local passwordInput = GUI.Input(anx(150), any(150), anx(348), any(98), "DLG_CONVERSATION.TGA", "FONT_OLD_20_WHITE_HI.TGA", Input.Password, Align.Center, ">               ", 2, windowLogin);
local buttonLeftBottomCorner = GUI.Button(0, any(250), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "", windowLogin);
local buttonLoginDo = GUI.Button(anx(150), any(250), anx(350), any(50), "INV_SLOT_FOCUS.TGA", "ZALOGUJ", windowLogin);
local buttonExitInfo = GUI.Button(anx(500), -any(50), anx(150), any(50), "INV_SLOT_FOCUS.TGA", "WyjdŸ z gry", windowLogin);

// Feedback window
// It's used for displaying informations about user's requests (registering). 
local windowFeedback = GUI.Window(4096 - anx(250), 4096 - any(175), anx(500), any(300), "MENU_INGAME.TGA", null, true);
local buttonRegisterStatusInfoClose = GUI.Button(anx(450), 0, anx(50), any(25), "INV_SLOT_FOCUS.TGA", "X", windowFeedback);
local drawRegisterStatusInfo = GUI.Draw(anx(30), any(120), "", windowFeedback);

// -------------------- FEEDBACK WINDOW -------------------- //
// Functions for displaying or hiding feedback window
function displayWindowFeedback (info) {
	drawRegisterStatusInfo.setText(info);
	windowRegister.setVisible(false);
	windowFeedback.setVisible(true);
	buttonRegisterStatusInfoClose.setVisible(true);
}
function hideWindowFeedback () {
	drawRegisterStatusInfo.setText("");
	windowFeedback.setVisible(false);
	windowRegister.setVisible(true);
}

// -------------------- INTERACTING WITH REGISTER WINDOW -------------------- //
local interactingWindowRegister = {

	// Displaying register window after "onInit" event. "Initialize" table for handling requests from register panel.
	"onInitWindowRegister" : function () {
		setCursorVisible(true);
		windowRegister.setVisible(true);
		// This window describes the operation of the button "X". It should be visible only after hovering the cursor over the button.
		buttonRegisterExitInfo.setVisible(false);
		registerLoginInput.setDisabled(false);
		registerPasswordInput.setDisabled(false);
		windowFeedback.setVisible(false);
		registerAccountClient.init(registerLoginInput, registerPasswordInput);
	},

	// Handling clicking on register window.
	"onClickWindowRegister" : function (self) {
		switch (self) {
			case buttonRegisterClose:
				exitGame();
				break;
				
			case buttonRegisterDo:
				registerAccountClient.refreshInputsData();
				if (registerAccountClient.checkRequirements()) {
					registerAccountClient.sendRequestToServer();
				} else {
					displayWindowFeedback (registerAccountClient.getFeedbackMsg());
				}
				break;
			
			case buttonRegisterStatusInfoClose:
				if (windowFeedback.getVisible()) {
					hideWindowFeedback();
				}
				break;
		}
	},

	// Handling driving the mouse in register window.
	"onMouseInWindowRegister" : function (self) {
		switch (self) {
			case buttonRegisterDo:
				self.setColor(255, 0, 0);
				break;
			
			case buttonRegisterClose:
				self.setColor(255, 0, 0);
				buttonRegisterExitInfo.setVisible(true);
				break;
				
			case buttonRegisterStatusInfoClose:
				if (buttonRegisterStatusInfoClose.getVisible()) {
					self.setColor(255, 0, 0);
				}
				break;
		}
	},

	// Handling driving the mouse out of register window.
	"onMouseOutWindowRegister" : function (self) {
		switch (self) {
			case buttonRegisterDo:
				self.setColor(255, 255, 255);
				break;
			
			case buttonRegisterClose:
				self.setColor(255, 255, 255);
				buttonRegisterExitInfo.setVisible(false);
				break;
				
			case buttonRegisterStatusInfoClose:
				if (buttonRegisterStatusInfoClose.getVisible()) {
					self.setColor(255, 255, 255);
				}
				break;
		}
	},

	//Display data about registration request.
	"onPacketRegistrationResponse" : function (packet) {
		local packetId = packet.readUInt16();
		switch (packetId) {
			case PacketsIds.REGISTER_PWDLOGIN_TO_CLIENT_RESPONSE:
				Chat.print(0, 255, 0, "ReturnedFromServer"); // TEST
				displayWindowFeedback(packet.readString());
				break;
		}
	}
};

// Attach event handlers.
addEventHandler("onInit", interactingWindowRegister.onInitWindowRegister);
addEventHandler("GUI.onClick", interactingWindowRegister.onClickWindowRegister);
addEventHandler("GUI.onMouseIn", interactingWindowRegister.onMouseInWindowRegister);
addEventHandler("GUI.onMouseOut", interactingWindowRegister.onMouseOutWindowRegister);
addEventHandler("onPacket", interactingWindowRegister.onPacketRegistrationResponse);

// -------------------- INTERACTING WITH LOGIN WINDOW -------------------- //
local interactingWindowLogin = {
	// Displaying login window after "onInit" event.
	"onInitWindowLogin" : function () {
		setCursorVisible(true);
		windowLogin.setVisible(true);
		loginInput.setDisabled(false);
		passwordInput.setVisible(true);
		//Q: Czemu trzeba ustawiæ akurat ten input osobno na "visible"; a ¿eby by³o widaæ resztê, wystarczy³o ustawiæ na "visible" 'window'?
		//Q c.d.: Bo by³ to ostatni zdefiniowany input?
		passwordInput.setDisabled(false);
		buttonExitInfo.setVisible(false);
	},

	// Handling clicking on login window.
	"onClickWindowLogin" : function (self) {
		switch (self) {
			case buttonClose:
				exitGame();
				break;
		}
	},

	// Handling driving the mouse in login window.
	"onMouseInWindowLogin" : function (self) {
		if (!(self instanceof GUI.Button)) {
			return;
		}
		
		if (self == buttonLoginDo) {
			self.setColor(255, 0, 0);
		} else if (self == buttonClose) {
			self.setColor(255, 0, 0);
			buttonExitInfo.setVisible(true);
		}
	},

	// Handling driving the mouse out of login window.
	"onMouseOutWindowLogin" : function (self) {
		if (!(self instanceof GUI.Button)) {
			return;
		}
		
		if (self == buttonLoginDo) {
			self.setColor(255, 255, 255);
		} else if (self == buttonClose) {
			self.setColor(255, 255, 255);
			buttonExitInfo.setVisible(false);
		}
	}
};

// Attach event handlers.
addEventHandler("onInit", interactingWindowLogin.onInitWindowLogin);
addEventHandler("GUI.onClick", interactingWindowLogin.onClickWindowLogin);
addEventHandler("GUI.onMouseIn", interactingWindowLogin.onMouseInWindowLogin);
addEventHandler("GUI.onMouseOut", interactingWindowLogin.onMouseOutWindowLogin);
