-- Gamestate = require "hump.gamestate"
-- require "gameSetup"



--require "menu"
--require "mapScreen"

--THIS SHOULD BE IN GAME SETUP ACTUALLY
res   = require 'res'

gw,gh = 320,240
sw,sh = love.graphics.getWidth(),love.graphics.getHeight()
--sw,sh = 1920,1080
mode  = 'fit'
res.set(mode,gw,gh,sw,sh)
font  = love.graphics.newFont(16)
love.graphics.setFont(font)
love.graphics.setDefaultFilter( "nearest", "nearest", 0 )

tween = require("loveframes.third-party.tween")
require("loveframes.loveframes")

require 'MainMenuController'

currentState = MainMenuController
newState = MainMenuController

love.mouse.setVisible(false);
mouseCursorImage = love.graphics.newImage("graphics/cursor.png");

function setState(state)
	newState = state;
end

function love.load()
    --Gamestate.registerEvents()
	--Gamestate.switch(menu)
end

function love.update(dt)
	if currentState ~= newState then
		currentState:leave();
		currentState = newState;
		loveframes.SetState(currentState.framesState);
		currentState:enter();
	end
	currentState:update(dt);
	loveframes.update(dt);
end

function drawWhole()
	currentState.draw();
	loveframes.draw();
	local widthFactor = gw / sw;
	local heightFactor = gh / sh;
	local x, y = love.mouse.getPosition();
	local x = x * widthFactor;
	local y = y * heightFactor;
	love.graphics.draw(mouseCursorImage,x,y);
	--mouseCursorImage
end

function love.draw()
	res.render(drawWhole);
	--loveframes.draw();
end

function love.load()
    --Gamestate.registerEvents()
	--Gamestate.switch(menu)
end

function love.mousemoved(x, y, button)
	-- translate mouse!
	widthFactor = gw / sw;
	heightFactor = gh / sh;
	newX = x*widthFactor;
	newY = y*heightFactor;
	print(newX)
	print(newY)
    loveframes.mousemoved(x*widthFactor, y*heightFactor, button)
end

function love.mousepressed(x, y, button)
	-- translate mouse!
	widthFactor = gw / sw;
	heightFactor = gh / sh;
	newX = x*widthFactor;
	newY = y*heightFactor;
	print(newX)
	print(newY)
    loveframes.mousepressed(x*widthFactor, y*heightFactor, button)
end
 
function love.mousereleased(x, y, button)
    loveframes.mousereleased(x*widthFactor, y*heightFactor, button)
end
 
function love.keypressed(key, unicode)
    loveframes.keypressed(key, unicode)
end

function love.keyreleased(key)
    loveframes.keyreleased(key)
	if key == 'escape' then
		love.event.quit()
    end
end



