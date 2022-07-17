// Registration: client side table
registerAccountClient <- {};

// Extending table by setting delegate and...
registerAccountClient.setdelegate(processPanelCommon);

// ...creating or rewriting properties and methods.
registerAccountClient._input_login <- null;
registerAccountClient._input_pwd <- null;
registerAccountClient.init <- function (input_login, input_pwd) {
	_input_login = input_login;
	_input_pwd = input_pwd;
	_login = _input_login.getText();
	_pwd = _input_pwd.getText();
};
registerAccountClient.refreshInputsData <- function () {
	if (_input_login && _input_pwd) {
		_login = _input_login.getText();
		_pwd = _input_pwd.getText();
	}
};
registerAccountClient.sendRequestToServer <- function () {
	local packet = Packet();
	packet.writeUInt16(PacketsIds.REGISTER_PWDLOGIN_TO_SERVER);
	packet.writeString(_login);
	packet.writeString(_pwd);
		
	packet.send(RELIABLE);
};