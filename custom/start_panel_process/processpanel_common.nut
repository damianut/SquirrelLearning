// Base class for handling register and login account requests.
class ProcessPanelCommon {
    _msgs = [
        "Login should contains from 4 to 15 chars. And only consist of numbers and letters.", // "Login powinien zawierać od 4 do 15 znaków. I składać się tylko z cyfr i liter."
        "Password should contains from 8 to 20 chars. And only consist of numbers and letters.", // "Hasło powinno zawierać od 8 do 20 znaków. I składać się tylko z cyfr i liter."
        "The account has been created.", // "Konto zostało utworzone."
        "The given login is taken.", // "Podany login jest zajęty."
        "The account with given login isn't exist.", // "Konto z podanym loginem nie istnieje."
        "Given password isn't correct." // "Podane hasło jest nieprawdiłowe."
    ];
    _login = null;
    _pwd = null;
    _feedbackMsg = null;
    _tmp_feedbackMsg = null;
    
    constructor (login, pwd) {
        _login = login;
        _pwd = pwd;
    }
    
    function refresh (login, pwd) {
        _login = login;
        _pwd = pwd;
    }
    
    // This function return and erase property with message.
    function getFeedbackMsg () {
        _tmp_feedbackMsg = _feedbackMsg;
        _feedbackMsg = null;
        return _tmp_feedbackMsg;
    }
    
    function checkLoginPwdRequirements () {
        local _satisfied = true;
        //Check constraints of login and password.
        if (!_checkLoginConstraints()) {
            _feedbackMsg = _msgs[0];
            _satisfied = false;
        } else if (!_checkPwdConstraints()) {
            _feedbackMsg = _msgs[1];
            _satisfied = false;
        }
        return _satisfied;
    }
    
    // -------------------- PRIVATE METHODS -------------------- //
    function _checkLoginConstraints () {
        return (
            (4 <= _login.len()) &&
            (15 >= _login.len()) &&
            regexpAlphanumericOnly(_login)
        );
    }
    
    function _checkPwdConstraints () {
        return (
            (8 <= _pwd.len()) &&
            (20 >= _pwd.len()) &&
            regexpAlphanumericOnly(_pwd)
        );
    }
}