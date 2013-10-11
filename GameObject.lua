------------------------------------------------------------------------------
--DECLARATIONS

Anim = {}
GameObject = {}

------------------------------------------------------------------------------
--INTERPOLATORS

interpolator_linear = function(x)
	return x;
end

interpolator_deaccelerate = function(x)
	return (1.0 - (1.0 - x) * (1.0 - x)); -- decelerate
end

interpolator_accelerate = function(x)
	return x * x;
end

------------------------------------------------------------------------------
--ANIMATION

Anim.__index = Anim;

setmetatable(Anim, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
});

function Anim.new(dur)
  local self = setmetatable({}, Anim);
  self.started 	= false;
  self.finished = false;
  self.duration = dur;
  self.elapsed 	= 0;
  self.delay 	= 0;
  self.rotation = 0;
  self.scaleX 	= 0;
  self.scaleY 	= 0;
  self.transX 	= 0;
  self.transY 	= 0;
  self.interp 	= interpolator_linear;
  return self
end

function Anim:start()
	self.started = true;
end

function Anim:update (dt, go)
	if not self.started then 
		return;
	end
	local prev_elapsed = self.elapsed;
	self.elapsed = self.elapsed + dt;
	if self.elapsed > self.duration then
		dt = dt - (self.elapsed - self.duration);
		self.elapsed 	= self.duration;
		self.started 	= false;
		self.finished 	= true;
	end

	local t1 = prev_elapsed / self.duration;
	local t2 = self.elapsed / self.duration;
	local ti = self.interp(t2) - self.interp(t1);

	go.x = go.x + ti * self.transX;
	go.y = go.y + ti * self.transY;
	go.rotation = go.rotation + ti * self.rotation;
	go.scalex = go.scalex + ti * self.scaleX;
	go.scaley = go.scaley + ti * self.scaleY;
end

------------------------------------------------------------------------------
--GAME OBJECT

GameObject.__index = GameObject;

setmetatable(GameObject, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
});

function GameObject.new(imageString)
  local self = setmetatable({}, GameObject);
  self.animations 	= {};
  self.image 		= love.graphics.newImage(imageString);
  self.x 			= 0;
  self.y 			= 0;
  self.rotation 	= 0;
  self.scalex 		= 1.0;
  self.scaley 		= 1.0;
  return self
end

function GameObject:draw()
	love.graphics.draw(self.image, 
		self.x, self.y, 
		self.rotation, 
		self.scalex, self.scaley, 
		self.image:getWidth()/2 , 
		self.image:getHeight()/2);
end

function GameObject:addAnim(animation)
	table.insert(self.animations,1,animation);
end

function GameObject:update (dt)
	for key, animation in pairs(self.animations) do
		animation:update(dt, self);
	end
	-- update with animations
end
