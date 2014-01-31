--mouse setup
GameSetup = {
	mainMenu = {},
	mapMenu = {}
}

function GameSetup:setup()
	-- Custom Cursor
	local mouseCursorImage = love.graphics.newImage("graphics/cursor.png");
	local mouseCursor = love.mouse.newCursor(mouseCursorImage:getData());
	love.mouse.setCursor(mouseCursor);
	
	-- GUI
	tween = require("loveframes.third-party.tween")
	require("loveframes.loveframes")
	self:setupMainMenuView();
	self:setupMapScreenMenuView();
end

function GameSetup:setupMainMenuView()
	local menuWidth = love.graphics.getWidth() / 4;
	local menuHeight = love.graphics.getHeight() / 2;
	local buttonWidth = menuWidth - 20;
	local buttonHeight = (menuHeight - 10) / 2;
	
	local panel = loveframes.Create("panel")
	panel:SetState("MainMenu")
	panel:SetSize(menuWidth,menuHeight)
	panel:Center()
	
	local form = loveframes.Create("form", panel)
	form:SetState("MainMenu")
	form:SetLayoutType("vertical")
	form:SetName("Main Menu")
	
	GameSetup.mainMenu.mapButton = loveframes.Create("button")
	local button = GameSetup.mainMenu.mapButton;
	button:SetWidth(buttonWidth)
	button:SetText("See Map")
	--button:Center()
	--button:SetY(button:GetY() - button:GetHeight()/2)
	button:SetState("MainMenu")
	form:AddItem(button)

	GameSetup.mainMenu.exitButton = loveframes.Create("button")
	local exitButton = GameSetup.mainMenu.exitButton;
	--exitButton:Center()
	--exitButton:SetY(exitButton:GetY() + exitButton:GetHeight()/2)
	exitButton:SetWidth(buttonWidth)
	exitButton:SetText("Exit Game")
	exitButton:SetState("MainMenu")
	form:AddItem(exitButton)
	
	form:Center()
end

function GameSetup:setupMapScreenMenuView() 
	local menuWidth = 800;
	local menuHeight = 60;
	local buttonWidth = menuWidth - 20;
	local buttonHeight = 30;
	
	local panel = loveframes.Create("panel")
	panel:SetState("mapScreen")
	panel:SetSize(menuWidth,menuHeight)
	panel:CenterX()
	panel:SetY(love.graphics.getHeight() - menuHeight)
	
	local form = loveframes.Create("form", panel)
	form:SetState("mapScreen")
	form:SetLayoutType("vertical")
	form:SetName("Actions")
	
	GameSetup.mapMenu.backButton = loveframes.Create("button", form)
	local backButton = GameSetup.mapMenu.backButton;
	backButton:SetWidth(buttonWidth)
	backButton:SetHeight(buttonHeight)
	backButton:SetText("Back to Menu")
	backButton:SetState("mapScreen")
	
	form:AddItem(backButton)
	form:Center()
end

GameSetup:setup();