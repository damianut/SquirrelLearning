// Class for handling registration or login request on client side.
class ProcessPanelClient extends ProcessPanelCommon {
    _input_login = null;
    _input_pwd = null;
    
    constructor (input_login, input_pwd) {
        _input_login = input_login;
        _input_pwd = input_pwd;
        base.constructor(_input_login.getText(), _input_pwd.getText());
    }
    
    function refreshInputsData () {
        if (_input_login && _input_pwd) {
            _login = _input_login.getText();
            _pwd = _input_pwd.getText();
        }
    }
    
    function sendRequestToServer (requestType) {
        if (("register" == requestType) || ("login" == requestType)) {
            local EnumHeader = ("register" == requestType) ?
                PacketsIds.REGISTER_ACC_REQUEST_TO_SERVER : PacketsIds.LOGIN_ACC_REQUEST_TO_SERVER;
            local packet = Packet();
            packet.writeUInt16(EnumHeader);
            packet.writeString(_login);
            packet.writeString(_pwd);
                
            packet.send(RELIABLE);
        }
    }
    
    //Display data about server response.
    function serverResponse (packet) {
		local packetId = packet.readUInt16();
		switch (packetId) {
			case PacketsIds.REGISTER_ACC_RESPONSE_TO_CLIENT:
				_feedbackMsg = packet.readString();
				break;
            case PacketsIds.LOGIN_ACC_RESPONSE_TO_CLIENT:
				_feedbackMsg = packet.readString();
				break;
		}
	}
}
