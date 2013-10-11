Writing = {
	pos_x	= 0;
	pos_y	= 0;
}

Writing.__index = Writing;

setmetatable(Writing, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
});

function Writing.new(initText)
  local self = setmetatable({}, Writing);
  self.text = initText or "HELLO!";
  return self
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