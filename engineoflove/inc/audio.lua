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

eol.audio={}

function eol.audio.keydown(_key)
    if eol.var.audio.enabled then
        for _k,_v in pairs(keys.audio) do
            -- toggle audio mute if mute key pressed
            if _k=="mute" and _v.v==_key then
                if eol.var.audio.muted then
                    eol.var.audio.muted=false
                    eol.osd.msg="audio\nunmuted"
                else
                    eol.var.audio.muted=true
                    eol.osd.msg="audio\nmuted"
                end
            end
            -- decrease volume if voldown key pressed
            if _k=="voldown" and _v.v==_key then
                eol.var.audio.volume=eol.var.audio.volume-eol.var.audio.step
                if eol.var.audio.volume<0 then eol.var.audio.volume=0 end
                eol.osd.msg="volume\n"..eol.var.audio.volume.."%"
            end
            -- increase volume if volup key pressed
            if _k=="volup" and _v.v==_key then
                eol.var.audio.volume=eol.var.audio.volume+eol.var.audio.step
                if eol.var.audio.volume>100 then eol.var.audio.volume=100 end
                eol.osd.msg="volume\n"..eol.var.audio.volume.."%"
            end
        end
    end
end
