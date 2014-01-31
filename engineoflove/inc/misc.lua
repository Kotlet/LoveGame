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

eol.misc={}

function eol.misc.init()
    -- determine if this is first run, to throw away first update()
    eol.misc.firstrun=true

    -- remove debug table if this is a release version, also set global variable
    eol.misc.release=false
    if love.conf then
        local _conf={}
        _conf.screen={}
        love.conf(_conf)
        if _conf.release then eol.misc.release=_conf.release end
    end
    if eol.misc.release then debug=nil end
end

function eol.misc.keydown(_key)
    for _k,_v in pairs(keys.misc) do
        -- exit program if quit key pressed
        if _k=="quit" and _v.v==_key then love.event.push("quit") break end
    end
end

-- convert color value given in rrggbb format to separated values ranging from 0-255 as required by LÖVE
function eol.misc.convertrgb(_c)
    return tonumber(string.sub(_c,1,2),16),tonumber(string.sub(_c,3,4),16),tonumber(string.sub(_c,5,6),16)
end
