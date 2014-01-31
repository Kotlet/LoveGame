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

eol.prefs={}

function eol.prefs.init()
    eol.prefs.obtain()

    -- see if preference files exist, if not create them
    if not love.filesystem.exists(eol.var.file.prefs) then eol.prefs.save(prefs,eol.var.file.prefs) else eol.prefs.load(prefs,eol.var.file.prefs) end
    if not love.filesystem.exists(eol.var.file.keys)  then eol.prefs.save(keys,eol.var.file.keys)   else eol.prefs.load(keys,eol.var.file.keys)   end

    eol.prefs.obtain()
end

function eol.prefs.load(_tbl,_file)
    -- iterate through lines in file
    for _l in love.filesystem.lines(_file) do

        -- convert line to lowercase and remove all spaces and tabs
        _l=string.lower(string.gsub(_l,"[ \t]",""))

        -- iterate through preference table
        for _k1,_v1 in pairs(_tbl) do
            for _k2,_v2 in pairs(_v1) do

                -- see if we find a preference key in current line
                if string.find(_l,"^".._k1..".".._k2) then

                    -- if the value is marked as fixed, don't read it and cancel further search
                    if _v2.f then break end

                    -- check if we get a value between = and --
                    local _v=string.match(_l,"=(.*)-%-")

                    -- we got nothing, maybe there's no -- in line, get everything from = to EOL
                    if not _v then _v=string.match(_l,"=(.*)") end

                    -- if we get "space", convert to " "
                    if _v=="space" then _v=" " end

                    -- convert values to their respective type
                    if type(_v2.v)=="number" then
                        local _n=tonumber(_v)
                        if _n then _v2.v=_n end
                    elseif type(_v2.v)=="boolean" then
                        if _v=="true" then _v2.v=true
                        elseif _v=="false" then _v2.v=false end
                    else _v2.v=_v end
                    break
                end
            end
        end
    end
end

function eol.prefs.save(_tbl,_file)
    local _kl,_vl=1,eol.var.misc.valuepad

    -- calculate formating for user config files
    for _k1,_v1 in pairs(_tbl) do
        for _k2,_v2 in pairs(_v1) do
            if _v2.x then
                if #(_k1..".".._k2)>_kl then _kl=#(_k1..".".._k2) end
                if #tostring(_v2.v)>_vl then _vl=#tostring(_v2.v) end
            end
        end
    end

    -- open config file for write
    local _f=assert(love.filesystem.newFile(_file))
    assert(_f:open('w'),"can't write to ".._file)

    -- write all key/value pairs to file
    for _k1,_v1 in pairs(_tbl) do
        for _k2,_v2 in pairs(_v1) do
            if _v2.x then _f:write(string.format("%-".._kl.."s",_k1..".".._k2).." = "..string.format("%-".._vl.."s",tostring(_v2.v)).." -- ".._v2.i.."\r\n") end
        end
    end

    _f:close()
end

function eol.prefs.obtain()
    eol.var={}
    for _k1 in pairs(prefs) do
        eol.var[_k1]={}
        for _k2 in pairs(prefs[_k1]) do eol.var[_k1][_k2]=prefs[_k1][_k2].v end
    end
end

function eol.prefs.record()
    for _k1 in pairs(prefs) do
        for _k2 in pairs(prefs[_k1]) do
            if prefs[_k1][_k2].a then prefs[_k1][_k2].v=eol.var[_k1][_k2] end
        end
    end
end
