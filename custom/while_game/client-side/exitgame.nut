// Save player's data while player is quiting.
function onExitSaveCharacter () {
    // Load all data from client side, that is needed to prepare and save player's data.
    // TODO: Save more or less data, after resizing database.
    // CURRENT: Only heroId and header is needed.
    local packet = Packet();
    packet.writeUInt16(PacketsIds.EXIT_PLAYER_DATA_TO_SERVER);
    packet.send(RELIABLE);
}
addEventHandler("onExit", onExitSaveCharacter);