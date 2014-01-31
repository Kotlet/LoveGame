GameWorld = {}

function GameWorld:init()
	self.ATL = require("AdvTiledLoader")
    self.ATL.Loader.path = 'maps/'
	self.map = self.ATL.Loader.load("small_island.tmx")
end

GameWorld:init();

