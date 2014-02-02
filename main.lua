
-- GAME SETUP
------------------------------------------------------------------------------
require "GameSetup"

--SOME CUSTOM FUNCTIONS
------------------------------------------------------------------------------

function setState(state)
	newState = state;
end

--LOVE CORE FUNCTIONS
------------------------------------------------------------------------------

function love.load()
    --Gamestate.registerEvents()
	--Gamestate.switch(menu)
end

function love.update(dt)
	if currentState ~= newState then
		if currentState ~= nil then
			currentState:leave();
		end
		currentState = newState;
		loveframes.SetState(currentState.framesState);
		currentState:enter();
	end
	currentState:update(dt);
	loveframes.update(dt);
	tween.update(dt);
end

function love.draw()
	GameSetup:drawpre();
	currentState:draw();
	loveframes.draw();
	local widthFactor = GameSetup.actual_w / GameSetup.screen_w;
	local heightFactor = GameSetup.actual_h / GameSetup.screen_h;
	local x, y = love.mouse.getPosition();
	local x = x * widthFactor;
	local y = y * heightFactor;
	x = math.floor(x);
	y = math.floor(y);
	love.graphics.draw(mouseCursorImage,x,y);
	GameSetup:drawpost();
end

--[[
function love.mousemoved(x, y, button)
	-- translate mouse!
	widthFactor = gw / sw;
	heightFactor = gh / sh;
	newX = x*widthFactor;
	newY = y*heightFactor;
    loveframes.mousemoved(x*widthFactor, y*heightFactor, button)
end
]]--

function love.mousepressed(x, y, button)
	local widthFactor = GameSetup.actual_w / GameSetup.screen_w;
	local heightFactor = GameSetup.actual_h / GameSetup.screen_h;
	local newX = x*widthFactor;
	local newY = y*heightFactor;
    loveframes.mousepressed(newX, newY, button)
end
 
function love.mousereleased(x, y, button)
	local widthFactor = GameSetup.actual_w / GameSetup.screen_w;
	local heightFactor = GameSetup.actual_h / GameSetup.screen_h;
	local newX = x*widthFactor;
	local newY = y*heightFactor;
    loveframes.mousereleased(newX, newY, button)
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



