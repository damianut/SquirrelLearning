function onInit()
{
    setKeyLayout(KEY_LAYOUT_PL);
	enableEvent_Render(true); // Enable execution of eventRender (on each frame).
    Chat.setVisible(false); // Player can see chat after login account.
}

addEventHandler("onInit", onInit)

function onCommand(cmd, params)
{
	switch (cmd)
	{
	case "show":
		setCursorVisible(true)
		break

	case "hide":
		setCursorVisible(false)
		break

	case "q":
		exitGame()
		break
		
	case "pos":
		local vec = getPlayerPosition(heroId)
		local angle = getPlayerAngle(heroId)
		
		print("x: " + vec.x + " y: " + vec.y + " z: " + vec.z + " angle: " + angle)
		break
	}
}

addEventHandler("onCommand", onCommand)