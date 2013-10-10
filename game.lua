------------------------------------------------------------------------------
--GAME

function game:enter()
    randomizedWriting   = Writing:new();
    time                = 0;
    deltaUpdate         = 0.3;
    width               = love.graphics.getWidth();
    height              = love.graphics.getHeight();
end

function game:keyreleased(key, code)
    if key == 'escape' then
        love.event.push("quit")
    end
end

function game:update(dt)
	time = time + dt;
	if time > deltaUpdate then
		time = time - deltaUpdate;
		randomizedWriting:update(width, height, 1);
	end
end

function game:draw()
    love.graphics.print(
    	randomizedWriting.text, 
    	randomizedWriting.pos_x, 
    	randomizedWriting.pos_y);
end