addEventHandler("onPlayerJoin", function(pid){
	if(getPlayerName(pid) == "Nickname"){
		kick(pid, "Zmie nick w launcherze Gothic 2 Online!")
	}
	sendMessageToPlayer(pid, 0, 255, 0, "Gamemode stworzony przez V0ID'a. Przepisany przez DamianQ.");
	sendMessageToPlayer(pid, 255, 145, 0, "Witaj na serwerze Cruzer RolePlay!");
	sendMessageToPlayer(pid, 255, 145, 0, "Wpisz /pomoc aby dowiedzie si jak gra na serwerze, powodzenia!");

	setPlayerColor(pid, 0, 255, 0);
});
