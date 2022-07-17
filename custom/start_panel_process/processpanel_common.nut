processPanelCommon <- {
    "_msgs" : [
		"Login should contains from 4 to 15 chars.", // "Login powinien zawierać od 4 do 15 znaków"
		"Password should contains from 8 to 20 chars." // "Hasło powinno zawierać od 8 do 20 znaków"
	],
    "_login" : null,
    "_pwd" : null,
    "_feedbackMsg" : null,
    "_tmp_feedbackMsg" : null,
    
    "init" : function (login, pwd) {
        _login = login;
        _pwd = pwd;
    },
    
    "refresh" : function (login, pwd) {
        init(login, pwd);
    },
    
    // This function return and erase property with message.
    "getFeedbackMsg" : function () {
        _tmp_feedbackMsg = _feedbackMsg;
        _feedbackMsg = null;
        return _tmp_feedbackMsg;
    },
    
    "checkRequirements" : function () {
        local _satisfied = true;
        //Check constraints of login and password.
        if (!_checkLoginConstraints()) {
            _input_login.setText("");
            //The password is removed so that the player does not forget what he typed.
            _input_pwd.setText("");
            _feedbackMsg = _msgs[0];
            _satisfied = false;
        } else if (!_checkPwdConstraints()) {
            _input_pwd.setText("");
            _feedbackMsg = _msgs[1];
            _satisfied = false;
        }
        return _satisfied;
    },
    
    // -------------------- PRIVATE METHODS -------------------- //
    "_checkLoginConstraints" : function ()
    {
        return (
            (4 <= _login.len()) &&
            (15 >= _login.len())// &&
            //Czy tutaj też dać wyrażenie regularne?
        );
    },
    
    "_checkPwdConstraints" : function ()
    {
        return (
            (8 <= _pwd.len()) &&
            (20 >= _pwd.len())// &&
            //Czy tutaj też dać wyrażenie regularne?
        );
    }
}