MainMenuController = {
	framesState = "MainMenuController";
	fps = 0;
}

function MainMenuController:init()
	local panel = loveframes.Create("panel");
	panel:SetState(self.framesState);

	local form = loveframes.Create("form", panel);
	form:SetState(self.framesState)
	form:SetLayoutType("vertical")
	form:SetName(love.window.getTitle())

	local exitButton = loveframes.Create("button")
	exitButton:SetWidth(200)
	exitButton:SetText("Quit");
	exitButton:SetState(self.framesState);
	exitButton.OnClick = function(object, x, y)
		love.event.quit();
	end

	local mapButton = loveframes.Create("button")
	mapButton:SetWidth(200)
	mapButton:SetText("SeeMap");
	mapButton:SetState(self.framesState);
	mapButton.OnClick = function(object, x, y)
		setState(MapController);
	end
	
	-- add more buttons here

	form:AddItem(mapButton);
	form:AddItem(exitButton);

	-- add buttons to form here

	panel:SetSize(form:GetWidth() + 10, form:GetHeight() + 10);
	panel:SetPos((GameSetup.actual_w - form:GetWidth() )/ 2, (GameSetup.actual_h - form:GetHeight()) / 2);
	form:Center();
end

function MainMenuController:enter()
	
end

function MainMenuController:leave()

end

function MainMenuController:draw()
	--love.graphics.print('Hello World!, fps is' .. self.fps, 0, 20)
end

function MainMenuController:update(dt)
	self.fps = love.timer.getFPS();
end

MainMenuController:init()
