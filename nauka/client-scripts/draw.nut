addEventHandler ("drawTest", function () {
	local drawInstance = Draw (500, 500, "Draaaaaw");
	drawInstance.top();
	drawInstance.visible = true;
});
local lineInstance = Line (1300, 1300, 4500, 4500);
lineInstance.setColor (122, 255, 111);
addEventHandler ("onPlayerMessage", function (playerid, r, g, b, message) {
	Chat.print(255, 255, 0, "startDrawTest");
	
	lineInstance.visible = true;
	lineInstance.top();
});