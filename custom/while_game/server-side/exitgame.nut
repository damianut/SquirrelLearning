function onExitClientSaveCharacter (pid, packet) {
    local packetId = packet.readUInt16();
    switch (packetId) {
        case PacketsIds.EXIT_PLAYER_DATA_TO_SERVER:
            print ("Here: 1");
            try {
                local dbHandler = PlayerDBHandling("user.db");
                if (dbHandler.saveCharacter(pid)) {
                    //LOG
                    print ("Here: 2");
                } else {
                    //LOG
                    print ("Here: 3");
                }
            } catch (msg) {
                print (msg);
                // TODO: msg for log
                // TODO: tworzenie logów
                print ("Here: 4");
            }
            print ("Here: 5");
            break;
    }
    
}

addEventHandler("onPacket", onExitClientSaveCharacter); 