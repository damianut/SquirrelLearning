//Registration
class RegisterAccountServer extends RegisterAccountCommon {
	_feedbackMsg = "";
	
	function processRegistration () {
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
	}
	
	function getFeedbackMsg () {
		return _feedbackMsg;
	}
}

function processRegistrationRequest(pid, packet) {
	local packetId = packet.readUInt16();
	switch (packetId) {
		case PacketsIds.REGISTER_PWDLOGIN_TO_SERVER:
			// Login and password are saved in packet after packetId.
			local RASInst = RegisterAccountServer(packet.readString(), packet.readString());
			RASInst.processRegistration();
			
			local feedbackPacket = Packet();
			feedbackPacket.writeUInt16(PacketsIds.REGISTER_PWDLOGIN_TO_CLIENT_RESPONSE);
			feedbackPacket.writeString(RASInst.getFeedbackMsg());
			feedbackPacket.send(pid, RELIABLE);
			break;
	}
}

addEventHandler("onPacket", processRegistrationRequest);