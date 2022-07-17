// Registration: server side table
registerAccountServer <- {};

// Extending table by setting delegate and...
registerAccountServer.setdelegate(processPanelCommon);

// ...creating or rewriting properties and methods.
registerAccountServer.checkRequirements <- function () {
	do {
		//Check constraints again in case the player changes the code on the client side.
		if (!_checkLoginConstraints()) {
			_feedbackMsg = _msgs[0];
			break;
		}
		if (!_checkPwdConstraints()) {
			_feedbackMsg = _msgs[1];
			break;
		}
		_feedbackMsg = _msgs[2];
	} while (false);
};
registerAccountServer.refreshLoginPwd <- function (login, pwd) {
	_login = login;
	_pwd = pwd;
};
registerAccountServer.processRegistrationRequest <- function (pid, packet) {
	local packetId = packet.readUInt16();
	switch (packetId) {
		case PacketsIds.REGISTER_PWDLOGIN_TO_SERVER:
			// Login and password are saved in packet after packetId.
			registerAccountServer.refreshLoginPwd(packet.readString(), packet.readString());
			registerAccountServer.checkRequirements();
			
			local feedbackPacket = Packet();
			feedbackPacket.writeUInt16(PacketsIds.REGISTER_PWDLOGIN_TO_CLIENT_RESPONSE);
			feedbackPacket.writeString(registerAccountServer.getFeedbackMsg());
			feedbackPacket.send(pid, RELIABLE);
			break;
	}
};
registerAccountServer._msgs.append("The account has been created."); //"Konto zostało utworzone",
registerAccountServer._msgs.append("The given login is taken."); //"Podany login jest zajęty"

// Attach table's function to event
addEventHandler("onPacket", registerAccountServer.processRegistrationRequest);