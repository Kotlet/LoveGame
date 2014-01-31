MapController = {
	framesState = "MapController";
}

function MapController:init()
	local panel = loveframes.Create("panel")
	panel:SetSize(gw,gh);
	panel:SetState(framesState);

	button = loveframes.Create("button", panel)
	button:SetWidth(200);
	button:SetText("Back");
	button:SetState(framesState);
	button:Center();
	
	
	--button:Center()
	--button:SetY(button:GetY() - button:GetHeight()/2)
end

function MapController:enter()
	loveframes.SetState(framesState);
end

function MapController:leave()

end

function MapController:draw()
	love.graphics.print('Hello World!', 100, 100)
end

function MapController:update()

end

MapController:init()