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

function love.run()

    math.randomseed(os.time())
    math.random() math.random()

    -- BEGIN EOL
    if eol.load then eol.load(arg) end
    -- END EOL
    if love.load then love.load(arg) end

    -- BEGIN EOL
    -- hook into keypressed handler
    local kp=love.handlers.keypressed
    function love.handlers.keypressed(...) if eol.keydown then eol.keydown(...) end return kp(...) end
    -- END EOL

    local dt = 0

    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
            love.event.pump()
            for e,a,b,c,d in love.event.poll() do
                if e == "quit" then
                    -- BEGIN EOL
                    eol.quit()
                    -- END EOL
                    if not love.quit or not love.quit() then
                        if love.audio then
                            love.audio.stop()
                        end
                        return
                    end
                end
                love.handlers[e](a,b,c,d)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        -- BEGIN EOL
        -- call eol.update but skip first dt value
        if eol.misc.firstrun then eol.misc.firstrun=false
        else
            if eol.update then eol.update(dt) end
            if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
        end
        -- END EOL

        -- Call update and draw
        if love.graphics then
            love.graphics.clear()

            -- BEGIN EOL
            -- switch to canvas
            if eol.drawpre then eol.drawpre() end
            -- END EOL
            
            if love.draw then love.draw() end

            -- BEGIN EOL
            -- blit canvas to screen
            if eol.drawpost() then eol.drawpost() end
            -- END EOL
        end

        if love.timer then love.timer.sleep(0.001) end
        if love.graphics then love.graphics.present() end

    end
end
