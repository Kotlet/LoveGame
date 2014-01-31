menu = {} -- previously: Gamestate.new()

function menu:enter()
	--GUI
	loveframes.SetState("MainMenu")
	GameSetup.mainMenu.mapButton.OnClick = function(object, x, y)
		Gamestate.switch(mapScreen)
	end
	GameSetup.mainMenu.exitButton.OnClick = function(object, x, y)
		love.event.quit( )
	end
end

function menu:update(dt)
	loveframes.update(dt)
end

function menu:draw()
	loveframes.draw()
end

function menu:mousepressed(x, y, button)
    loveframes.mousepressed(x, y, button)
end
 
function menu:mousereleased(x, y, button)
    loveframes.mousereleased(x, y, button)
end
 
function menu:keypressed(key, unicode)
    loveframes.keypressed(key, unicode)
end
 
function menu:keyreleased(key)
    loveframes.keyreleased(key)
	if key == 'escape' then
		love.event.quit()
    end
end