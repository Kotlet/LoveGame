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

eol.debug={}

function eol.debug.init()
    -- load font
    if eol.var.debug.font_type=="pixmap" then eol.debug.font=love.graphics.newImageFont(eol.var.debug.font_path,eol.charmap)
    elseif eol.var.debug.font_type=="ttf" then eol.debug.font=love.graphics.newFont(eol.var.debug.font_path,eol.var.debug.font_size)
    else eol.debug.font=love.graphics.newFont(eol.var.debug.font_size) end

    -- calculate horizontal gap inside debug rectangle
    eol.debug.hgap=(eol.debug.font:getWidth("1")/2)+eol.var.debug.gap_off

    -- calculate colors for background and font
    eol.debug.color_r,eol.debug.color_g,eol.debug.color_b          = eol.misc.convertrgb(eol.var.debug.color)
    eol.debug.bg_color_r,eol.debug.bg_color_g,eol.debug.bg_color_b = eol.misc.convertrgb(eol.var.debug.bg_color)

    -- populate system debug table
    eol.debug.system = {
        { n="memory usage",         f=function() return gcinfo().." kB" end  },
        { n="fps limit",            f=function() return eol.var.screen.fpslimit end },
        { n="fps",                  f=love.timer.getFPS },
        { n="screen resolution",    f=function() return love.graphics.getWidth().."x"..love.graphics.getHeight() end },
        { n="canvas resolution",    f=function() return eol.var.screen.canvas_w.."x"..eol.var.screen.canvas_h end },
        { n="canvas scaling",       f=function() return "x"..eol.screen.scale-eol.screen.scale%0.01 end },
        { n="canvas multiscale",    f=function() return eol.var.screen.multiscale end  },
        { n="canvas support",       f=function() return eol.screen.canvas_sup end  },
        { n="fullscreen",           f=function() local _w,_h,_fs=love.graphics.getMode() return _fs end },
        { n="vsync",                f=function() local _w,_h,_fs,_vs=love.graphics.getMode() return _vs end },
        { n="fsaa",                 f=function() local _w,_h,_fs,_vs,_aa=love.graphics.getMode() return _aa end },
        { n="audio enabled",        f=function() return eol.var.audio.enabled end },
        { n="audio muted",          f=function() return eol.var.audio.muted end },
        { n="audio volume",         f=function() return eol.var.audio.volume.."%" end },
    }
end

function eol.debug.update(_dt)
    if eol.var.debug.enabled and eol.var.debug.visible then
        local _d

        -- choose between user and system debug info
        if eol.var.debug.page=="user" and eol.debug.user then _d=eol.debug.user
        else _d=eol.debug.system end

        if _d then
            -- execute functions from debug table
            for _i,_v in ipairs(_d) do _d[_i].v=_v.f() end

            -- format and align name column
            local _c=0
            for _i,_v in ipairs(_d) do if #_v.n>_c then _c=#_v.n end end
            for _i,_v in ipairs(_d) do _d[_i].fn=string.format("%-".._c.."s",_v.n).." = " end

            -- combine keys and values to a formated string
            eol.debug.string=""
            eol.debug.width=0
            for _i=1,#_d do
                local _v=tostring(_d[_i].v)
                local _w=eol.debug.font:getWidth(_d[_i].fn.._v)
                if _w>eol.debug.width then eol.debug.width=_w end
                eol.debug.string=eol.debug.string.._d[_i].fn.._v.."\n"
            end
        end

        -- calculate dimensions of debug rectangle
        eol.debug.width=0
        for _l in string.gmatch(eol.debug.string,"[^\r\n]+") do
            if eol.debug.font:getWidth(_l)>eol.debug.width then eol.debug.width=eol.debug.font:getWidth(_l) end
        end
        eol.debug.height=eol.debug.font:getHeight(eol.debug.string)*#_d

        -- calculate y position of debug rectangle
        if eol.var.debug.valign=="bottom" then eol.debug.ypos=eol.var.screen.canvas_h-eol.debug.height-eol.var.debug.voff-eol.var.debug.height_off
        elseif eol.var.debug.valign=="center" then eol.debug.ypos=((eol.var.screen.canvas_h/2)-(eol.debug.height/2)+eol.var.debug.voff)-(eol.var.debug.height_off/2)
        else eol.debug.ypos=eol.var.debug.voff end
    
        -- calculate x position of debug rectangle
        if eol.var.debug.halign=="right" then eol.debug.xpos=eol.var.screen.canvas_w-eol.debug.width-eol.var.debug.hoff-eol.debug.hgap*2
        elseif eol.var.debug.halign=="center" then eol.debug.xpos=(eol.var.screen.canvas_w/2)-(eol.debug.width/2)+(eol.var.debug.hoff-eol.debug.hgap)
        else eol.debug.xpos=eol.var.debug.hoff end
    end
end

function eol.debug.draw()
    if eol.var.debug.enabled and eol.var.debug.visible and eol.debug.string then
        -- draw background rectangle
        love.graphics.setColor(eol.debug.bg_color_r,eol.debug.bg_color_g,eol.debug.bg_color_b,(1-eol.var.debug.bg_trans)*255)
        love.graphics.rectangle("fill",eol.screen.ofs_x_nocan+eol.debug.xpos,eol.screen.ofs_y_nocan+eol.debug.ypos,eol.debug.width+eol.debug.hgap*2,eol.debug.height+eol.var.debug.height_off)

        -- draw debug string
        love.graphics.setFont(eol.debug.font)
        love.graphics.setColor(eol.debug.color_r,eol.debug.color_g,eol.debug.color_b,(1-eol.var.debug.trans)*255)
        love.graphics.print(eol.debug.string,eol.screen.ofs_x_nocan+eol.debug.xpos+eol.debug.hgap,eol.screen.ofs_y_nocan+eol.debug.ypos+eol.var.debug.vtext_off)
    end
end

function eol.debug.keydown(_key)
    if eol.var.debug.enabled then
        for _k,_v in pairs(keys.debug) do
            -- toggle visibility of debug info if toggle key pressed
            if _k=="toggle" and _v.v==_key then
                eol.var.debug.visible=not eol.var.debug.visible
                break end
            -- switch between system and user debug page if page key pressed
            if _k=="page" and _v.v==_key then
                if eol.var.debug.page=="user" then eol.var.debug.page="system"
                else
                    if eol.debug.user then eol.var.debug.page="user" end
                break end
            end
        end
    end
end
