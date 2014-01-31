MainMenuController = {
	framesState = "MainMenuController";
}

function MainMenuController:init()
	local panel = loveframes.Create("panel");
	panel:SetState(framesState);
	panel:SetSize(gw,gh);

	local button = loveframes.Create("button", panel)
	button:SetWidth(200)
	button:SetText("See Map");
	button:SetState(framesState);
	button:Center();
	--button:Center()
	--button:SetY(button:GetY() - button:GetHeight()/2)
end

function MainMenuController:enter()
	
end

function MainMenuController:leave()

end

function MainMenuController:draw()
	love.graphics.print('Hello World!', 100, 100)
end

function MainMenuController:update()

end

MainMenuController:init()
