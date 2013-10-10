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