enum PacketsIds
{
    // Register
	REGISTER_ACC_REQUEST_TO_SERVER,
    REGISTER_ACC_RESPONSE_TO_CLIENT,
    // Login
    LOGIN_ACC_REQUEST_TO_SERVER,
    LOGIN_ACC_RESPONSE_TO_CLIENT,
    LOGIN_ACC_DO,
    // Exit game
    EXIT_PLAYER_DATA_TO_SERVER
}

// Processing string
// Check that string contains only alphanumeric chars.
function regexpAlphanumericOnly (str) {
    return !regexp(@"\W+").capture(str);
}