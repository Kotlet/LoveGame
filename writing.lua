Writing = {
	text 	= "HELLO!";
	pos_x	= 0;
	pos_y	= 0;
}

function Writing:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Writing:update (width, height, exclamations)
	if exclamations > 0 then
		for i=1,exclamations do
			self.text = string.format("%s!",self.text);
		end
	end
	self.pos_x = math.random(0, width);
	self.pos_y = math.random(0, height);
end