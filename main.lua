------------------------------------------------------------------------------
--CONFIG

Gamestate = require("gamestate");
require("writing");

menu = {}
game = {}

dofile("LoveGame/menu.lua");
dofile("LoveGame/game.lua");

------------------------------------------------------------------------------
--LOVE

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end