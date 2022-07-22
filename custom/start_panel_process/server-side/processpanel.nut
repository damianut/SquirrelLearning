// Class for handling registration or login request on server side.
class ProcessPanelServer extends ProcessPanelCommon {
    static _dbName = "user.db";
    _dbHandler = null;
    
    function init () {
        _dbHandler = PlayerDBHandling (_dbName);
    }
    
    function processRequest (pid, packet) {
        local packetId = packet.readUInt16();
        switch (packetId) {
            case PacketsIds.REGISTER_ACC_REQUEST_TO_SERVER:
                // TEST

                // END TEST
                // Login and password are saved in packet after packetId.
                refresh(packet.readString(), packet.readString());
                // I check the login and password again if the player has influenced the data after the first check and before sending the request.
                try {
                    if (!checkLoginPwdRequirements()) {
                        throw "";
                    }
                    if (_dbHandler.checkPlayerExistsInDatabase(_login)) {
                        throw _msgs[3];
                    }
                    setPlayerName (pid, _login);
                    _dbHandler.createCharacter(pid, _login, md5(_pwd));
                    _feedbackMsg = _msgs[2];
                } catch (msg) {
                    if ("" != msg) {
                        _feedbackMsg = msg;
                    }
                }
                _prepareFeedbackPacket(PacketsIds.REGISTER_ACC_RESPONSE_TO_CLIENT).send(pid, RELIABLE);
                break;
            case PacketsIds.LOGIN_ACC_REQUEST_TO_SERVER:
                local userExists = null;
                local pwdCorrect = null;
                // Login and password are saved in packet after packetId.
                refresh(packet.readString(), packet.readString());
                // I check the login and password again if the player has influenced the data after the first check and before sending the request.
                do {
                    if (!checkLoginPwdRequirements()) {
                        break;
                    }
                    try {
                        userExists = _dbHandler.checkPlayerExistsInDatabase(_login);
                    } catch (msg) {
                        _feedbackMsg = msg;
                    }
                    if (!userExists) {
                        _feedbackMsg = _msgs[4];
                        break;
                    }
                    try {
                        pwdCorrect = _dbHandler.comparePwd(_login, _pwd);
                    } catch (msg) {
                        _feedbackMsg = msg;
                    }
                    if (!pwdCorrect) {
                        _feedbackMsg = _msgs[5];
                    }
                } while (false);
                local serverLoginCorrect = false;
                if (pwdCorrect) {
                    try {
                        serverLoginCorrect = _loginDo(pid, _dbHandler.getPlayerData(_login));
                    } catch (msg) {
                        _feedbackMsg = msg;
                    }
                }
                local feedbackPacketId = serverLoginCorrect ? PacketsIds.LOGIN_ACC_DO : PacketsIds.LOGIN_ACC_RESPONSE_TO_CLIENT;
                _prepareFeedbackPacket(feedbackPacketId).send(pid, RELIABLE);                
                break;
        }
	}
    
    // -------------------- PRIVATE METHODS -------------------- //
    function _prepareFeedbackPacket (header) {
        local feedbackPacket = Packet();
        feedbackPacket.writeUInt16(header);
        feedbackPacket.writeString(getFeedbackMsg());
        
        return feedbackPacket;
    }
    
    function _loginDo(pid, userData) {
        setPlayerName (pid, userData.name);

        // Stats
        setPlayerHealth(pid,  userData.hp.tointeger());
        setPlayerMaxHealth(pid, userData.maxHP.tointeger());
        setPlayerMana(pid, userData.mana.tointeger());
        setPlayerMaxMana(pid, userData.maxMana.tointeger());
        setPlayerStrength(pid, 10);
        setPlayerDexterity(pid, 10);
        
        // Weapon skill percent
        setPlayerSkillWeapon(pid, WEAPON_1H, 10);
        setPlayerSkillWeapon(pid, WEAPON_2H, 10);
        setPlayerSkillWeapon(pid, WEAPON_BOW, 10);
        setPlayerSkillWeapon(pid, WEAPON_CBOW, 10);
        
        spawnPlayer(pid);
        setPlayerPosition(pid, userData.posX.tofloat(), userData.posY.tofloat(), userData.posZ.tofloat());
        
        sendMessageToAll(0, 255, 0, getPlayerName(pid) + " connected with the server.")
        
        return true;
    }
}
// Base class needs strings in constructor. But this instance is created before any player register request.
// So in this place login and password from player isn't known.
local PPSInst = ProcessPanelServer("", "");
PPSInst.init();
addEventHandler("onPacket", function (pid, packet) {
    PPSInst.processRequest(pid, packet);
});