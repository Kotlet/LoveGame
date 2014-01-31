"Engine Of Love" is a framework for the LÖVE game engine and provides additional functionality.

CONTENTS
--------

* [Features](#features)
* [Usage](#usage)
* [Configuration](#configuration)
* [Shortkeys](#shortkeys)
* [Screen Scaling](#screen-scaling)
* [FPS Capping](#fps-capping)
* [OSD](#osd)
* [Debug Box](#debug-box)
* [Release](#release)
* [Tutorial](#tutorial)
* [Notes](#notes)
* [Donation](#donation)
* [License](#license)

FEATURES
--------

- management of user preferences
- configurable key bindings for changing screen, audio and debug settings while the program is running
- scales and centers the screen to any resolution (needs canvas support)
- FPS capping with configurable key bindings
- OSD (on screen display) of any message with customizable appearance
- debug information which can be shown inside the window, user can add a table with own debug parameters, appearance is fully customizable
- release vs. development: if t.release is true, Lua debug functions are disabled

USAGE
-----

It's very easy to use the framework, only a few simple steps have to be followed:

- after downloading place the "engineoflove" subfolder into your game root directory (where your main.lua is)
- add the following line to your main.lua:   
<code>require "engineoflove"</code>

Voila!
All the additional functions are now immediately available to your game.

CONFIGURATION
-------------

There are two files inside the <code>engineoflove</code> directory which are used for configuration purposes: <code>keys.lua</code> and <code>prefs.lua</code>.

Every configuration item has a maximum of five fields attached to it:

* <code>x</code> -- is this configuration item exposed to the user configuration?
* <code>f</code> -- is this item fixed, means it cannot be altered from the user configuration file?
* <code>a</code> -- is this item automatically saved when the program quits?
* <code>v</code> -- the actual value of the settings item
* <code>i</code> -- an info field for a description of the preferences item

When the program is started for the first time, two configuration files are generated, their names are defined in <code>prefs.file.prefs</code> and <code>prefs.file.keys</code>.
They can be found below <code>~/.local/share/love/</code> in the subdirectory which is defined by <code>t.identity</code> in your <code>conf.lua</code> file.
Both files include only the configuration items marked with <code>x=true</code>.

Once the user configuration files are created, their settings items which have been marked with <code>f=false</code> override the internal settings, therefor modifying these items in <code>keys.lua</code> or <code>pregs.lua</code> will have no effect anymore.

For easy separation of your (the game developers) preferences from the framework's defaults, it also looks for the files <code>keys.lua</code> and <code>prefs.lua</code> in your main folder, right there where <code>main.lua</code> resides.   
You can override any default configuration items inside these files, you can simply assign new values.

Here is an example <code>prefs.lua</code> which should reside in the same folder than your <code>main.lua</code> file.
Remember to remove the user <code>game.cfg</code> file every time you change parameters in <code>prefs.lua</code>.

    -- we want vsync to be turned on by default
    prefs.screen.vsync.v  = true

    -- the debug box should be visible by default and should display the user debug page if defined
    prefs.debug.visible.v = true
    prefs.debug.page.v    = "user"

    -- the debug box should be aligned to the right of the drawing area
    -- we also want to hide this parameter from the user game.cfg by setting x to false
    -- also the user shouldn't be able to add this parameter manually, so we set it with f to fixed
    -- you will notice that "prefs.debug.halign" will not appear again in the users game.cfg file
    prefs.debug.halign.v  = "right"
    prefs.debug.halign.x  = false
    prefs.debug.halign.f  = true

    -- the volume should be 50% by default
    prefs.audio.volume.v  = 50

SHORTKEYS
---------

All shortkeys are configured in <code>engineoflove/keys.lua</code>.    
To disable a shortkey completely, an empty value <code>v=""</code> can be used.

There are already many keys defined by default, e.g. F1-F6 change screen mode settings, F7-F9 change audio related settings and F11-F12 toggle debug information.
For a full list of shortkeys consult the <code>keys.lua</code> file itself.

If a <code>keys.lua</code> file is found in the same folder than <code>main.lua</code> it will be used to override default parameters.

Here is an example <code>keys.lua</code> which should reside in the same folder than your <code>main.lua</code> file.
Remember to remove the user <code>keys.cfg</code> file every time you change parameters in <code>keys.lua</code>.

    -- we want to quit the program with q
    keys.misc.quit.v="q"

    -- we want to disable shortkeys for changing FSAA values alltogether
    -- we hide this shortkey from the user keys.cfg by setting x to false
    -- also the user shouldn't be able to add this parameter manually, so we set it with f to fixed
    -- you will notice that "keys.screen.fsaa_less" and "keys.screen.fsaa_more" will not appear anymore in the user keys.cfg file
    -- remember to remove the user keys.cfg file every time you change parameters here or in engineoflove/prefs.lua
    keys.screen.fsaa_less.v=""
    keys.screen.fsaa_less.x=false
    keys.screen.fsaa_less.f=true

    keys.screen.fsaa_more.v=""
    keys.screen.fsaa_more.x=false
    keys.screen.fsaa_more.f=true

SCREEN SCALING
--------------

The canvas size has default values of 512x384 pixels.   
These are reasonable values for displaying pixelart graphics on commonly used screen resolutions.   
For an explanation of this choice please refer to this article by SiENcE: [crankgaming.blogspot.de](http://crankgaming.blogspot.de/2013/01/aeon-of-sands-pyramid-scaling.html).

There are two scaling modes which can be controlled by the <code>prefs.screen.multiscale</code> parameter:

If <code>multiscale</code> is set to true, the canvas will be centered and only scaled to multiple sizes of itself. This assures that pixelart graphics are not distorted and pixels are always square (thanks [SiENcE](https://love2d.org/forums/viewtopic.php?f=5&t=33142#p101760)).   

If it is false, all graphics are scaled to the active window size even if the scale factor is a fractional value.
This will guarantee that the graphics will always fill the whole window, but will cause visible distortions on pixelart graphics.

__Both scaling methods need canvas support.__

To still provide some kind of nice screen setup even without canvas support, offset values are written to <code>eol.screen.ofs_x_nocan</code> and <code>eol.screen.ofs_y_nocan</code>.

These two variables contain 0 in case canvases are used and a nonzero value if canvases are not supported.
If these variables are added to all coordinates in the program, the graphics will still be centered even without canvas support.

Example:

    function love.draw()
        local _x=eol.screen.ofs_x_nocan
        local _y=eol.screen.ofs_y_nocan

        love.graphics.setColor(255,0,0)
        love.graphics.rectangle("fill",_x+0,_y+0,640,480)
    end

FPS CAPPING
-----------

The frame rate of the program is capped to 80fps by default.   
The hotkeys KeyPad- and KeyPad+ are assigned to de- and increase the FPS limit while the program is running, the initial limit can be adjusted using the <code>prefs.screen.fpslimit</code> parameter.
A value of 0 (zero) means that capping is disabled and the program runs at maximum fps.   

It's probably a good idea to have fps capping enabled, too many frames waste precious CPU time and the human eye cannot even tell a difference anymore.

OSD
---

To show OSD (On Screen Display) event information just pass any single or multiline string to <code>eol.osd.msg</code>.    

The OSD is displayed with the parameters from the <code>osd</code> section of the preferences.
Nearly every aspect of it is heavily customizable, e.g. colors, transparency, position, alignment and font.

By default screen actions (e.g. resolution changes, toggling of vsync and fullscreen) and audio related events (e.g. volume changes and toggling mute) are shown with OSD, but any string passed to <code>eol.osd.msg</code> will be displayed as well.

DEBUG BOX
---------

By default, the display of debug information is entirely disabled.   
To enable it, you first need to create the file <code>prefs.lua</code> in the same folder as <code>main.lua</code> and add following line to it:   
<code>prefs.debug.enabled.v=true</code>.

The F11 key toggles the display of the debug box, nearly every visual aspects can be controlled in the preferences.   
There are two pages available which can be toggled by default with F12:

### system debug information

This page shows system internal values, e.g. framerate, memory consumption, screen and audio settings.

### user debug information

The user can add his own debug information which will be shown here.
As long as the <code>eol.debug.user</code> is empty, this page can not be selected.

This table can be defined e.g. inside love.load() and has the following format:

    eol.debug.user = {
        { n="<name>", f=<function> },
        { n="<name>", f=<function> },
        ...
    }

<code>n</code> is the name of the parameter and <code>f</code> contains a function, it's return value will be shown in the debug information.

Example:

    game_status="ingame"

    eol.debug.user = {
        { n="game status", f=function() return game_status end },
        { n="clock", f=os.clock },
    }

will result in a user debug display similar to:

    game status = ingame
    clock       = 0.51

RELEASE
-------

EOL checks if you have a <code>conf.lua</code> file inside your main folder. If yes, then it checks the <code>t.release</code> parameter.   
If it is found and set to true (means you are going to release your game) then it disables Lua's debug functionality by setting <code>debug</code> to <code>false</code>.

It is recommended by the Lua developers to disable <code>debug</code> on release as your code will be faster.

The global variable <code>eol.misc.release</code> reflects the release settings and is true if <code>t.release</code> is set, false otherwise.

To use debug functionality inside your game, it should be done with conditions, e.g.:

    if not eol.misc.release then debug.debug() end

TUTORIAL
--------

The following code is an example <code>main.lua</code> with comments which should explain the EOL usage.   
It's fully working, just name it <code>main.lua</code> and move the <code>engineoflove</code> folder to the same location.

    -- The following optional block (until love.load()) is a mechanism for easy enabling/disabling EOL from within your code.
    -- If the EOL folder can't be found, it will be autodisabled.

    -- change this variable to "false" if you want to disable EOL
    use_eol=true

    -- check if the EOL folder exists inside the game's main directory, if not EOL will be disabled alltogether
    if use_eol then use_eol=love.filesystem.exists("engineoflove") end

    -- if EOL is enabled and the folder exists, load all the EOL stuff
    if use_eol then require "engineoflove" end

    function love.load()
        -- The following block is an example on how to use a user defined debug table.
        -- "n" contains the displayed name, "f" contains a function to return the actual value to display.
        -- Remember that the debug information window can be toggled with F11 by default.
        -- F12 switches between our user defined debug information and a predefined system debug page provided by EOL.

        -- some random game variables
        game   = { status="running" }
        player = { x=50, y=40, vel=50 }

        -- our own debug table which will be displayed on top of everything in the canvas
        if use_eol then eol.debug.user = {
            { n="game.status",      f=function() return game.status end },
            { n="os.date",          f=os.date },
            { n="player position",  f=function() local _s="x:"..math.floor(player.x)..", y:"..math.floor(player.y) return _s end },
        } end
    end

    function love.update(dt)
        -- only update the game if it's running
        if game.status=="running" then
            -- some code to move the imaginary player
            if love.keyboard.isDown("left")  then player.x=player.x-dt*player.vel end
            if love.keyboard.isDown("right") then player.x=player.x+dt*player.vel end
            if love.keyboard.isDown("up")    then player.y=player.y-dt*player.vel end
            if love.keyboard.isDown("down")  then player.y=player.y+dt*player.vel end
        end
    end

    function love.draw()
        --  EOL provides offset values to center everything we draw inside the window.
        --  The following code is an example how to add the values to all x and y coordinates even on systems without canvas support.
        --  It should remain at the beginning of love.draw()

        -- we use zero values for offsets in case EOL is disabled
        local _xeol=0
        local _yeol=0
        -- set the canvas width to window width and height in case EOL is disabled
        local _weol=love.graphics.getWidth()
        local _heol=love.graphics.getHeight()

        if use_eol then
            -- if EOL is enabled, we copy the offset values from EOL variables
            _xeol=eol.screen.ofs_x_nocan
            _yeol=eol.screen.ofs_y_nocan
            -- we also get the canvas dimensions from the preferences
            _weol=eol.screen.canvas_w
            _heol=eol.screen.canvas_h
        end

        -- Here you can add your own drawing routines.
        -- The following code is an example how to use the offset variables
        -- and how to get the dimensions of the drawable area.

        -- we fill the whole drawable area with a background color
        love.graphics.setColor(26,12,34,255)
        love.graphics.rectangle("fill",0,0,_weol,_heol)

        -- if game status is running, display game graphics
        if game.status=="running" then
            -- from now on we add the offset values to all positions, for example:
            love.graphics.setColor(88,165,116,255)
            love.graphics.rectangle("fill",_xeol+140,_yeol+170,40,40)

            love.graphics.setColor(34,176,56,255)
            love.graphics.rectangle("fill",_xeol+player.x,_yeol+player.y,30,30)
        -- if game is paused, display text
        elseif game.status=="pause" then
            local _text="PAUSE"
            local _font=love.graphics.setNewFont(22)
            love.graphics.setColor(34,176,56,255)
            love.graphics.print(_text,_xeol+_weol/2,_yeol+_heol/2,0,1,1,_font:getWidth(_text)/2,_font:getHeight(_text)/2)
        end
    end

NOTES
-----

### love callback functions

The framework overrides the default <code>love.run()</code> function provided by LÖVE 0.8.
If you need to change <code>love.run()</code>, you need to modify the existing function in <code>engineoflove/inc/callbacks.lua</code> instead of defining it again.   
It's important that nothing between <code>-- BEGIN EOL</code> and <code>-- END EOL</code> is modified and the position of these blocks are not changed.

### canvas switching

If you have code in your program for canvas switching, then you should remove it.
The framework automagically takes care of it, so your canvas code might interfere with the existing code.

### first call to love.update()

The first call to <code>love.update()</code> after the program starts is actually thrown away.    
If your game loads lots of stuff in the beginning, the first <code>dt</code> value will be pretty big, it can be several seconds or more.
his huge <code>dt</code> value could cause a jump in the beginning of your game depending on how you handle the update code, that's why EOL automatically skips it.

DONATION
--------
If you like the project please consider donating via paypal (paypal_my@callistix.net) or [gittip](https://www.gittip.com/humansarepuppies/).

LICENSE
-------
    Cheese Defender, defend your cheese against evil zombie mice.
    Copyright (C) 2013 vitaminx / Humans Are Puppies

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
