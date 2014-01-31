require "GameWorld"

mapScreen = {}

local tx, ty = 0, 0
local map = GameWorld.map 

function mapScreen:enter()
	local height = love.graphics.getHeight();
	local width = love.graphics.getWidth();
	local centerarea = {0, 0, width /2 , height/2}

    -- setup entities here
	map = GameWorld.map
	
	-- setup GUI
	loveframes.SetState("mapScreen")
	
	GameSetup.mapMenu.backButton.OnClick = function(object, x, y)
		Gamestate.switch(menu)
	end
end

function mapScreen:update(dt)
	if love.keyboard.isDown("up") then ty = ty + 250*dt end
    if love.keyboard.isDown("down") then ty = ty - 250*dt end
    if love.keyboard.isDown("left") then tx = tx + 250*dt end
    if love.keyboard.isDown("right") then tx = tx - 250*dt end
	
	loveframes.update(dt)
	tween.update(dt)
end

function mapScreen:draw()
	-- Draws the map
	-- Apply the translation
    love.graphics.translate( math.floor(tx), math.floor(ty) )

    -- Set the draw range. Setting this will significantly increase drawing performance.
    map:autoDrawRange( math.floor(tx), math.floor(ty), 1, pad)

    -- Draw the map
    map:draw()
	
	-- Draw the GUI
	love.graphics.translate( -math.floor(tx), -math.floor(ty) )
	loveframes.draw();
end

function mapScreen:keyreleased(key, code)
    if key == 'escape' then
		Gamestate.switch(menu)
    end
end

function mapScreen:mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)	
end

function mapScreen:mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)	
end