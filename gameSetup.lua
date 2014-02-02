GameSetup = {
	actual_w = 320;
	actual_h = 240;
}

--GUI
tween = require("loveframes.third-party.tween")
require("loveframes.loveframes")

-- SCREENS
------------------------------------------------------------------------------
require 'MainMenuController'
require 'MapController'
currentState = nil
newState = MainMenuController

function GameSetup:init(aw, ah)
	require 'msr'
	self.screen_w = msr.screen_w;
	self.screen_h = msr.screen_h;

	-- Custom Cursor
	love.mouse.setVisible(false);
	mouseCursorImage = love.graphics.newImage("graphics/cursor.png");
end

function GameSetup:drawpre()
	msr.drawpre();
end

function GameSetup:drawpost()
	msr.drawpost();
end

GameSetup:init(640, 480);