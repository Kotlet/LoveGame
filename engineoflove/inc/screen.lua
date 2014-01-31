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

eol.screen={}

function eol.screen.init()
    -- set default line style
    love.graphics.setLineStyle("rough")

    -- get and sort graphics modes
    eol.screen.modes=love.graphics.getModes()
    table.sort(eol.screen.modes,function(a,b) return a.width*a.height<b.width*b.height end)

    -- if requested screen mode not supported, fall back to first mode in list
    if not love.graphics.checkMode(eol.var.screen.width,eol.var.screen.height,eol.var.screen.fullscreen) then
        eol.var.screen.width=eol.screen.modes[1].width
        eol.var.screen.height=eol.screen.modes[1].height
    end

    -- set screen mode and mouse pointer
    love.graphics.setMode(eol.var.screen.width,eol.var.screen.height,eol.var.screen.fullscreen,eol.var.screen.vsync,eol.var.screen.fsaa)
    if not eol.var.screen.pointer then love.mouse.setVisible(false) end

    -- create canvas if supported
    if love.graphics.isSupported("canvas") and eol.var.screen.usecanvas then
        eol.screen.canvas_sup=true
        eol.screen.canvas=love.graphics.newCanvas(eol.var.screen.canvas_w,eol.var.screen.canvas_h)
        eol.screen.canvas:setFilter("nearest","nearest")
    else eol.screen.canvas_sup=false end

    -- calculate scaling and position of drawing area
    eol.screen.calcscale(eol.var.screen.width,eol.var.screen.height)

    -- get initial timestamp if fps is capped
    if eol.var.screen.fpslimit>0 then eol.screen.dtnext=love.timer.getMicroTime() end
end

function eol.screen.update(_dt)
    -- add to timer if fps is capped
    if eol.var.screen.fpslimit>0 then eol.screen.dtnext=eol.screen.dtnext+1/eol.var.screen.fpslimit end
end

function eol.screen.drawpre()
    -- switch to canvas if supported
    if eol.screen.canvas_sup then love.graphics.setCanvas(eol.screen.canvas) end

    -- clean background
    love.graphics.setBackgroundColor(0,0,0,255)
    love.graphics.clear()
end

function eol.screen.drawpost()
    if eol.screen.canvas_sup then
        -- switch to screen and clean it
        love.graphics.setCanvas()
        love.graphics.setBlendMode("premultiplied")
        love.graphics.setBackgroundColor(0,0,0,255)
        love.graphics.setColor(255,255,255,255)
        love.graphics.clear()

        -- blit scaled and translated canvas to screen
        love.graphics.draw(eol.screen.canvas,eol.screen.ofs_x,eol.screen.ofs_y,0,eol.screen.scale)
        love.graphics.setBlendMode("alpha")
    end
    
    -- sleep if fps is capped
    if eol.var.screen.fpslimit>0 then
        local _time=love.timer.getMicroTime()
        if eol.screen.dtnext<=_time then
            eol.screen.dtnext=_time
            return
        end
        love.timer.sleep(eol.screen.dtnext-_time)
    end
end

function eol.screen.keydown(_key)
    for _k,_v in pairs(keys.screen) do

        -- switch to smaller screen mode
        if _k=="smaller" and _v.v==_key then
            local _w,_h,_fs,_vs,_aa=love.graphics.getMode() 
            for _i,_v in ipairs(eol.screen.modes) do
                if _v.width==_w and _v.height==_h then
                    local _index=_i-1
                    if _index<1 then _index=#eol.screen.modes end
                    eol.var.screen.width  = eol.screen.modes[_index].width
                    eol.var.screen.height = eol.screen.modes[_index].height

                    love.graphics.setMode(eol.var.screen.width,eol.var.screen.height,_fs,_vs,_aa)
                    eol.screen.calcscale(eol.var.screen.width,eol.var.screen.height)
                    eol.osd.msg=eol.var.screen.width.."x"..eol.var.screen.height
                    break
                end
            end
            break end

        -- switch to bigger screen mode
        if _k=="bigger" and _v.v==_key then
            local _w,_h,_fs,_vs,_aa=love.graphics.getMode() 
            for _i,_v in ipairs(eol.screen.modes) do
                if _v.width==_w and _v.height==_h then
                    local _index=_i+1
                    if _index>#eol.screen.modes then _index=1 end
                    eol.var.screen.width  = eol.screen.modes[_index].width
                    eol.var.screen.height = eol.screen.modes[_index].height

                    love.graphics.setMode(eol.var.screen.width,eol.var.screen.height,_fs,_vs,_aa)
                    eol.screen.calcscale(eol.var.screen.width,eol.var.screen.height)
                    eol.osd.msg=eol.var.screen.width.."x"..eol.var.screen.height
                    break
                end
            end
            break end

        -- toggle fullscreen
        if _k=="fullscreen" and _v.v==_key then
            love.graphics.toggleFullscreen()
            local _w,_h,_vs,_aa
            _w,_h,eol.var.screen.fullscreen,_vs,_aa=love.graphics.getMode()
            if eol.var.screen.fullscreen then eol.osd.msg="FULLSCREEN\nON" else eol.osd.msg="FULLSCREEN\nOFF" end
            break end

        -- toggle vsync
        if _k=="vsync" and _v.v==_key then
            local _w,_h,_fs,_vs,_aa=love.graphics.getMode() 
            if _vs then love.graphics.setMode(_w,_h,_fs,false,_aa) else love.graphics.setMode(_w,_h,_fs,true,_aa) end
            _w,_h,_fs,eol.var.screen.vsync,_aa=love.graphics.getMode()
            if eol.var.screen.vsync then eol.osd.msg="VSYNC\nON" else eol.osd.msg="VSYNC\nOFF" end
            break end

        -- decrease FSAA samples
        if _k=="fsaa_less" and _v.v==_key then
            local _w,_h,_fs,_vs,_aa=love.graphics.getMode()
            local _old_aa=_aa
            _aa=_aa-1
            if _aa<0 then _aa=0 end
            love.graphics.setMode(_w,_h,_fs,_vs,_aa)
            local _w,_h,_fs,_vs
            _w,_h,_fs,_vs,eol.var.screen.fsaa=love.graphics.getMode()
            if _old_aa~=eol.var.screen.fsaa then eol.osd.msg="FSAA x "..eol.var.screen.fsaa end
            break end

        -- increase FSAA samples
        if _k=="fsaa_more" and _v.v==_key then
            local _w,_h,_fs,_vs,_aa=love.graphics.getMode()
            local _old_aa=_aa
            _aa=_aa+1
            if _aa>128 then _aa=128 end
            love.graphics.setMode(_w,_h,_fs,_vs,_aa)
            local _w,_h,_fs,_vs
            _w,_h,_fs,_vs,eol.var.screen.fsaa=love.graphics.getMode()
            if _old_aa~=eol.var.screen.fsaa then eol.osd.msg="FSAA x "..eol.var.screen.fsaa end
            break end

        -- decrease FPS limit
        if _k=="fps_less" and _v.v==_key then
            eol.var.screen.fpslimit=math.floor(eol.var.screen.fpslimit-5)
            if eol.var.screen.fpslimit<0 then eol.var.screen.fpslimit=0 end
            break end

        -- increase FPS limit
        if _k=="fps_more" and _v.v==_key then
            eol.var.screen.fpslimit=math.floor(eol.var.screen.fpslimit+5)
            break end
    end
end

function eol.screen.calcscale(_w,_h)
    -- calculate aspect ratios
    local _aspect_win=_w/_h
    local _aspect_can=eol.var.screen.canvas_w/eol.var.screen.canvas_h

    if _aspect_win<_aspect_can then
        -- we need vertical offset, calculate it
        eol.screen.scale = _w/eol.var.screen.canvas_w
        eol.screen.ofs_x = 0
        eol.screen.ofs_y = (_h-(eol.var.screen.canvas_h*eol.screen.scale))/2
    else
        -- we need horizontal offset, calculate it
        eol.screen.scale = _h/eol.var.screen.canvas_h
        eol.screen.ofs_x = (_w-(eol.var.screen.canvas_w*eol.screen.scale))/2
        eol.screen.ofs_y = 0
    end

    -- if multiscale is enabled (scale canvas only to multiple sizes), find right scale and offsets
    if eol.var.screen.multiscale then
        local _intscale=math.floor(eol.screen.scale)
        local _hgap=_w-eol.var.screen.canvas_w*_intscale
        local _vgap=_h-eol.var.screen.canvas_h*_intscale

        if _hgap>0 then eol.screen.ofs_x=_hgap/2 end
        if _vgap>0 then eol.screen.ofs_y=_vgap/2 end

        eol.screen.scale=_intscale
    end

    if eol.screen.canvas_sup then
        -- if we have canvas support, set helper variables to zero
        eol.screen.ofs_x_nocan = 0
        eol.screen.ofs_y_nocan = 0
    else
        -- if canvas is unsupported, set helper variables to offset values
        eol.screen.ofs_x_nocan = (_w-eol.var.screen.canvas_w)/2
        eol.screen.ofs_y_nocan = (_h-eol.var.screen.canvas_h)/2
    end
end
