------------------------------------------------------------------------------
--GAME

love.filesystem.load("GameObject.lua")();

local animate = function(go)
    local objectAnimation = Anim(5.7);
    objectAnimation.transY = height/2 - object.y;
    objectAnimation.interp = interpolator_deaccelerate;
    go:addAnim(objectAnimation);
    objectAnimation:start();

    local oax = Anim(5.7);
    oax.transX = width/2 - object.x;
    oax.interp = interpolator_accelerate;
    object:addAnim(oax);
    oax:start();

    local objectAnimationRotation = Anim(5.7);
    objectAnimationRotation.rotation = -20.0 * math.pi;
    objectAnimationRotation.interp = interpolator_deaccelerate;
    go:addAnim(objectAnimationRotation);
    objectAnimationRotation:start();

    local oasx = Anim(5.7);
    oasx.scaleX = (width / object.image:getWidth())-object.scalex;
    oasx.interp = interpolator_accelerate;
    go:addAnim(oasx);
    oasx:start();

    local oasy = Anim(5.7);
    oasy.scaleY = (height / object.image:getHeight())-object.scaley;
    oasy.interp = interpolator_accelerate;
    go:addAnim(oasy);
    oasy:start();
end

function game:enter()
    randomizedWriting   = Writing("some text!");
    object              = GameObject("funny.jpg");
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

function game:keypressed(key, code)
    if key == ' ' then
        animate(object);
    end
end

function game:update(dt)
    if time == 0 then -- first update - create anim
    end
	time = time + dt;
	if time > deltaUpdate then
		time = time - deltaUpdate;
		randomizedWriting:update(width, height, 1);
	end
    object:update(dt);
end

function game:draw()
    love.graphics.print(
    	randomizedWriting.text, 
    	randomizedWriting.pos_x, 
    	randomizedWriting.pos_y);
    object:draw();
end