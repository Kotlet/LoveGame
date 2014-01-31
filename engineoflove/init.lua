--[[
        Engine Of Love - a framework for the LÖVE game engine
        Copyright (C) 2013 vitaminx (vitaminx@callistix.net)

        This program is free software: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

local _path=(...)

require(_path.."/inc/callbacks")
require(_path.."/inc/main")
require(_path.."/inc/const")

require(_path.."/prefs")
if love.filesystem.isFile("prefs.lua") then require "prefs" end
require(_path.."/keys")
if love.filesystem.isFile("keys.lua") then require "keys" end

require(_path.."/inc/prefs")
require(_path.."/inc/screen")
require(_path.."/inc/audio")
require(_path.."/inc/osd")
require(_path.."/inc/debug")
require(_path.."/inc/misc")
