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

eol={}

function eol.load(_arg)
    eol.prefs.init()
    eol.screen.init()
    eol.osd.init()
    eol.misc.init()
    eol.debug.init()
end

function eol.update(_dt)
    eol.screen.update(_dt)
    eol.debug.update(_dt)
    eol.osd.update(_dt)
end

function eol.drawpre()
    eol.screen.drawpre()
end

function eol.drawpost()
    eol.osd.draw()
    eol.debug.draw()
    eol.screen.drawpost()
end

function eol.keydown(...)
    eol.debug.keydown(arg[1])
    eol.screen.keydown(arg[1])
    eol.audio.keydown(arg[1])
    eol.misc.keydown(arg[1])
end

function eol.quit()
    eol.prefs.record()
    eol.prefs.save(prefs,eol.var.file.prefs)
end
