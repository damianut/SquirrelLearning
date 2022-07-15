class RegisterAccountCommon
{
	static _msgs = [
		"Login should contains from 4 to 15 chars.",//"Login powinien zawierać od 4 do 15 znaków",
		"Password should contains from 8 to 20 chars.",//"Hasło powinno zawierać od 8 do 20 znaków",
		"The account has been created.",//"Konto zostało utworzone",
		"The given login is takien."//"Podany login jest zajęty"
	];
	
	_login = "";
	_pwd = "";
	
	constructor (login, pwd)
	{
		_login = login;
		_pwd = pwd;
	}
	
	function _checkLoginConstraints ()
	{
		return (
			(4 <= _login.len()) &&
			(15 >= _login.len())// &&
			//Czy tutaj też dać wyrażenie regularne?
		);
	}
	
	function _checkPwdConstraints ()
	{
		return (
			(8 <= _pwd.len()) &&
			(20 >= _pwd.len())// &&
			//Czy tutaj też dać wyrażenie regularne?
		);
	}
}