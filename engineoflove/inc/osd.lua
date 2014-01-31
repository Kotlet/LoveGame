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

eol.osd={}

function eol.osd.init()
    -- load font
    if eol.var.osd.font_type=="pixmap" then eol.osd.font=love.graphics.newImageFont(eol.var.osd.font_path,eol.charmap)
    elseif eol.var.osd.font_type=="ttf" then eol.osd.font=love.graphics.newFont(eol.var.osd.font_path,eol.var.osd.font_size)
    else eol.osd.font=love.graphics.newFont(eol.var.osd.font_size) end

    -- calculate horizontal gap inside OSD rectangle
    eol.osd.hgap=(eol.osd.font:getWidth("1")/2)+eol.var.osd.gap_off

    -- calculate colors for background and font
    eol.osd.color_r,eol.osd.color_g,eol.osd.color_b          = eol.misc.convertrgb(eol.var.osd.color)
    eol.osd.bg_color_r,eol.osd.bg_color_g,eol.osd.bg_color_b = eol.misc.convertrgb(eol.var.osd.bg_color)
end

function eol.osd.update(_dt)
    if eol.var.osd.enabled and eol.osd.msg then
        -- check if a new message arrived
        if eol.osd.msg~=eol.osd.msg_old then
            -- reset all values
            eol.osd.trans=1
            eol.osd.msg_old=eol.osd.msg
            eol.osd.timer=eol.var.osd.time+eol.var.osd.fadeout
            eol.osd.width=0

            -- calculate dimensions of rectangle
            local _lines=0
            for _l in string.gmatch(eol.osd.msg,"[^\r\n]+") do
                _lines=_lines+1
                if eol.osd.font:getWidth(_l)>eol.osd.width then eol.osd.width=eol.osd.font:getWidth(_l) end
            end
            eol.osd.height=eol.osd.font:getHeight(eol.osd.msg)*_lines

            -- calculate y position of OSD rectangle
            if     eol.var.osd.valign=="bottom" then eol.osd.ypos = eol.var.screen.canvas_h-eol.osd.height-eol.var.osd.voff-eol.var.osd.height_off
            elseif eol.var.osd.valign=="center" then eol.osd.ypos = ((eol.var.screen.canvas_h/2)-(eol.osd.height/2)+eol.var.osd.voff)-(eol.var.osd.height_off/2)
            else   eol.osd.ypos = eol.var.osd.voff end
    
            -- calculate x position of OSD rectangle
            if     eol.var.osd.halign=="right"  then eol.osd.xpos=eol.var.screen.canvas_w-eol.osd.width-eol.var.osd.hoff-eol.osd.hgap*2
            elseif eol.var.osd.halign=="center" then eol.osd.xpos=(eol.var.screen.canvas_w/2)-(eol.osd.width/2)+(eol.var.osd.hoff-eol.osd.hgap)
            else   eol.osd.xpos=eol.var..osd.hoff end
        else
            -- if no new message arrived then advance timer for old message
            eol.osd.timer=eol.osd.timer-_dt
            if eol.osd.timer<eol.var.osd.fadeout then
                eol.osd.trans=eol.osd.timer/eol.var.osd.fadeout
            end
            -- message expited, remove it
            if eol.osd.timer<0 then
                eol.osd.msg=nil
                eol.osd.msg_old=nil
            end
        end
    end
end

function eol.osd.draw()
    if eol.var.osd.enabled and eol.osd.msg then
        -- draw background rectangle
        love.graphics.setColor(eol.osd.bg_color_r,eol.osd.bg_color_g,eol.osd.bg_color_b,(1-eol.var.osd.bg_trans)*255*eol.osd.trans)
        love.graphics.rectangle("fill",eol.screen.ofs_x_nocan+eol.osd.xpos,eol.screen.ofs_y_nocan+eol.osd.ypos,eol.osd.width+eol.osd.hgap*2,eol.osd.height+eol.var.osd.height_off)

        -- draw OSD message
        love.graphics.setFont(eol.osd.font)
        love.graphics.setColor(eol.osd.color_r,eol.osd.color_g,eol.osd.color_b,(1-eol.var.osd.trans)*255*eol.osd.trans)
        love.graphics.printf(eol.osd.msg,eol.screen.ofs_x_nocan+eol.osd.xpos+eol.osd.hgap,eol.screen.ofs_y_nocan+eol.osd.ypos+eol.var.osd.vtext_off,eol.osd.width+eol.osd.hgap,eol.var.osd.text_align)
    end
end
