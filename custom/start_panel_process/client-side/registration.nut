//Registration
class RegisterAccountClient extends RegisterAccountCommon
{
	_input_login = null;
	_input_pwd = null;
	
	constructor (input_login_param, input_pwd_param)
	{
		Chat.print(0, 255, 0, "No siema: 1");
		_input_login = input_login;
		_input_pwd = input_pwd;
		base.constructor(input_login.getText(), input_pwd.getText());
	}
	
	function processRegistration()
	{
		Chat.print(0, 255, 0, "No siema: 2");
		//Check constraints of login and password.
		if (!_checkLoginConstraints())
		{
			Chat.print(0, 255, 0, "No siema: 2 1");
			_input_login.setText("");
			//The password is removed so that the player does not forget what he typed.
			_input_pwd.setText("");
			return msgs[0];
		}
		Chat.print(0, 255, 0, "No siema: 3");
		if (!_checkPwdConstraints())
		{
			_input_pwd.setText("");
			return msgs[1];
		};
		Chat.print(0, 255, 0, "No siema: 4");
		local packet = Packet();
		packet.writeUInt16(PacketsIds.REGISTER_PWDLOGIN_TO_SERVER);
		packet.writeString(login);
		packet.writeString(pwd);
		
		packet.send(RELIABLE);
	}
}