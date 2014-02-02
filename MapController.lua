require "GameWorld"

MapController = {
	framesState = "MapController";
}

local tx, ty = 0, 0
local map = GameWorld.map 

function MapController:init()
	-- GUI
	local panel = loveframes.Create("panel");
	panel:SetState(self.framesState);

	local form = loveframes.Create("form", panel);
	form:SetState(self.framesState)
	form:SetLayoutType("horizontal")
	form:SetName("Map")

	local exitButton = loveframes.Create("button")
	exitButton:SetWidth(200)
	exitButton:SetText("Back to Menu");
	exitButton:SetState(self.framesState);
	exitButton.OnClick = function(object, x, y)
		setState(MainMenuController);
	end

	-- add more buttons here

	form:AddItem(exitButton);

	-- add buttons to form here

	panel:SetSize(GameSetup.actual_w, form:GetHeight() + 10);
	panel:SetPos(0, GameSetup.actual_h - panel:GetHeight());
	form:Center();

	-- MAP
	local height = GameSetup.actual_h;
	local width = GameSetup.actual_w;
	local centerarea = {0, 0, width /2 , height/2}

    -- setup entities here
	map = GameWorld.map
end

function MapController:enter()

end

function MapController:leave()

end

function MapController:draw()
	-- Draws the map
	local transx = math.floor(tx * (GameSetup.actual_w/GameSetup.screen_w));
	local transy = math.floor(ty * (GameSetup.actual_h/GameSetup.screen_h));
    love.graphics.translate( transx, transy )
    map:autoDrawRange( transx, transy, 1, pad)
    map:draw()
	love.graphics.translate( -transx, -transy )
	love.graphics.print('Hello World!, fps is' .. self.fps, 0, 20)
end

function MapController:update(dt)
	if love.keyboard.isDown("up") then ty = ty + 250*dt end
    if love.keyboard.isDown("down") then ty = ty - 250*dt end
    if love.keyboard.isDown("left") then tx = tx + 250*dt end
    if love.keyboard.isDown("right") then tx = tx - 250*dt end
    self.fps = love.timer.getFPS();
end

MapController:init()