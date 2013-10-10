------------------------------------------------------------------------------
--CONFIG

Gamestate = require("gamestate");
require("writing");

time 		= 0;
deltaUpdate = 0.3;
width 		= love.graphics.getWidth();
height  	= love.graphics.getHeight();

------------------------------------------------------------------------------
--GAMESTATES

local menu = {}
local game = {}

------------------------------------------------------------------------------
--MENU

function menu:draw()
    love.graphics.print("Press Enter to continue", 10, 10)
end

function menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(game)
    end
    if key == 'escape' then
        love.event.push("quit")
    end
end

------------------------------------------------------------------------------
--GAME

function game:enter()
    randomizedWriting = Writing:new();
    time = 0;
    update = 0.1;
end

function game:update(dt)
	time = time + dt;
	if time > update then
		time = time - update;
		randomizedWriting:update(width, height, 1);
	end
end

function game:draw()
	love.graphics.print("State is - in game", 10, 10);

    love.graphics.print(
    	randomizedWriting.text, 
    	randomizedWriting.pos_x, 
    	randomizedWriting.pos_y);
end

------------------------------------------------------------------------------
--LOVE

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end