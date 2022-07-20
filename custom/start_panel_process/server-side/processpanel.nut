// Class for handling registration or login request on server side.
class ProcessPanelServer extends ProcessPanelCommon {
    function processRequest (pid, packet) {
        local packetId = packet.readUInt16();
        switch (packetId) {
            case PacketsIds.REGISTER_ACC_REQUEST_TO_SERVER:
                // Login and password are saved in packet after packetId.
                refresh(packet.readString(), packet.readString());
                // I check the login and password again if the player has influenced the data after the first check and before sending the request.
                do {
                    if (!checkLoginPwdRequirements()) {
                        break;
                    }
                    _testSQlite();
                
                } while (false);
                
                local feedbackPacket = Packet();
                feedbackPacket.writeUInt16(PacketsIds.REGISTER_ACC_RESPONSE_TO_CLIENT);
                feedbackPacket.writeString(getFeedbackMsg());
                feedbackPacket.send(pid, RELIABLE);
                break;
            case PacketsIds.LOGIN_ACC_REQUEST_TO_SERVER:
                // Login and password are saved in packet after packetId.
                refresh(packet.readString(), packet.readString());
                // I check the login and password again if the player has influenced the data after the first check and before sending the request.
                checkLoginPwdRequirements();
                
                local feedbackPacket = Packet();
                feedbackPacket.writeUInt16(PacketsIds.LOGIN_ACC_RESPONSE_TO_CLIENT);
                feedbackPacket.writeString(getFeedbackMsg());
                feedbackPacket.send(pid, RELIABLE);
                break;
        }
	}
    
    function _testSQLite () {
        print ("TestSQLite");
    }
}
// Base class needs strings in constructor. But this instance is created before any player register request.
// So in this place login and password from player isn't known.
local PPSInst = ProcessPanelServer("", "");
addEventHandler("onPacket", function (pid, packet) {
    PPSInst.processRequest(pid, packet);
});