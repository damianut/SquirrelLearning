if (addEvent ("drawTest"))
{
	print ("event DrawTest added");
} else
{
	print ("failure: event DrawTest not added");
}

addEventHandler ("onInit", function (playerid) {
	sendMessageToPlayer(playerid, 255, 255, 0, "onInit");
});

addEventHandler ("onPlayerJoin", function (playerid) {
	sendMessageToPlayer(playerid, 255, 255, 0, "onPlayerJoin");
});
