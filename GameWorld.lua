GameWorld = {}

function GameWorld:init()
	self.ATL = require("AdvTiledLoader")
    self.ATL.Loader.path = 'maps/'
	self.map = self.ATL.Loader.load("newMap.tmx")
end

GameWorld:init();

