prefs = {
    screen = {
        width      = { x=true,  f=false, a=true,  v=640,                                        i="initial window width" },
        height     = { x=true,  f=false, a=true,  v=480,                                        i="initial window height" },
        fullscreen = { x=true,  f=false, a=true,  v=false,                                      i="fullscreen" },
        vsync      = { x=true,  f=false, a=true,  v=false,                                      i="vertical sync" },
        fsaa       = { x=false, f=false, a=false, v=0,                                          i="number of FSAA samples" },
        fpslimit   = { x=false, f=false, a=false, v=80,                                         i="upper limit of framerate, 0 for no limit" },
        pointer    = { x=false, f=true,  a=false, v=false,                                      i="is mouse pointer visible?" },
        canvas_w   = { x=false, f=true,  a=false, v=512,                                        i="canvas width" },
        canvas_h   = { x=false, f=true,  a=false, v=384,                                        i="canvas height" },
        multiscale = { x=false, f=true,  a=false, v=true,                                       i="scale canvas only to multiples of original size (for pixelart)" },
        usecanvas  = { x=false, f=true,  a=false, v=true,                                       i="enable or disable canvas functions if supported" },
    },

    audio = {
        volume     = { x=true,  f=false, a=true,  v=80,                                         i="audio volume in percent from 0 to 100" },
        muted      = { x=true,  f=false, a=true,  v=false,                                      i="if audio is initially muted" },
        enabled    = { x=false, f=false, a=false, v=true,                                       i="enable or disable audio" },
        step       = { x=false, f=false, a=false, v=10,                                         i="amount of volume change on single keypress" },
    },

    osd = {
        enabled    = { x=false, f=false, a=false, v=true,                                       i="is OSD enabled" },
        time       = { x=false, f=false, a=false, v=1,                                          i="how many seconds OSD is shown" },
        fadeout    = { x=false, f=false, a=false, v=0.2,                                        i="how many seconds OSD fades out" },

        text_align = { x=false, f=false, a=false, v="right",                                    i="horizontal alignment of text: left, center or right" },
        halign     = { x=false, f=false, a=false, v="right",                                    i="horizontal alignment of box: left, center or right" },
        valign     = { x=false, f=false, a=false, v="top",                                      i="vertical alignment of box: top, center or bottom" },
        hoff       = { x=false, f=false, a=false, v=10,                                         i="horizontal offset of OSD" },
        voff       = { x=false, f=false, a=false, v=10,                                         i="vertical offet of OSD" },

        height_off = { x=false, f=false, a=false, v=3,                                          i="offsets the height of background box, can be negative" },
        vtext_off  = { x=false, f=false, a=false, v=2,                                          i="offsets the text vertically, can be negative" },
        gap_off    = { x=false, f=false, a=false, v=0,                                          i="offsets the horizontal gap of text in box, can be negative" },

        color      = { x=false, f=false, a=false, v="e0e0e0",                                   i="text color (rrggbb)" },
        trans      = { x=false, f=false, a=false, v=0.5,                                        i="transparency of text from 0.0 to 1.0" },
        bg_color   = { x=false, f=false, a=false, v="ffffff",                                   i="background color (rrggbb)" },
        bg_trans   = { x=false, f=false, a=false, v=0.9,                                        i="transparency of background from 0.0 to 1.0" },

        font_type  = { x=false, f=false, a=false, v="pixmap",                                   i="font type, 'internal', 'ttf' or 'pixmap'" },
        font_path  = { x=false, f=false, a=false, v="engineoflove/fonts/freesans_26.png",       i="path to ttf or pixmap font" },
        font_size  = { x=false, f=false, a=false, v=22,                                         i="font size, does nothing for pixmap fonts" },
    },

    debug = {
        enabled    = { x=false, f=true,  a=false, v=false,                                      i="is debug mode enabled" },
        visible    = { x=false, f=false, a=false, v=false,                                      i="is debug mode initially visible" },
        page       = { x=false, f=false, a=false, v="system",                                   i="which page to show initially, 'system' or 'user'" },

        halign     = { x=false, f=false, a=false, v="left",                                     i="horizontal alignment of box: left, center or right" },
        valign     = { x=false, f=false, a=false, v="bottom",                                   i="vertical alignment of box: top, center or bottom" },
        hoff       = { x=false, f=false, a=false, v=10,                                         i="horizontal offset of debug box" },
        voff       = { x=false, f=false, a=false, v=10,                                         i="vertical offet of debug box" },

        height_off = { x=false, f=false, a=false, v=7,                                          i="offsets the height of background box, can be negative" },
        vtext_off  = { x=false, f=false, a=false, v=3,                                          i="offsets the text vertically, can be negative" },
        gap_off    = { x=false, f=false, a=false, v=2,                                          i="offsets the horizontal gap of text in box, can be negative" },

        color      = { x=false, f=false, a=false, v="ffffff",                                   i="text color (rrggbb)" },
        trans      = { x=false, f=false, a=false, v=0.7,                                        i="transparency of text from 0.0 to 1.0" },
        bg_color   = { x=false, f=false, a=false, v="a0a0a0",                                   i="background color (rrggbb)" },
        bg_trans   = { x=false, f=false, a=false, v=0.9,                                        i="transparency of background from 0.0 to 1.0" },

        font_type  = { x=false, f=false, a=false, v="pixmap",                                   i="font type, 'internal', 'ttf' or 'pixmap'" },
        font_path  = { x=false, f=false, a=false, v="engineoflove/fonts/courier_new_12.png",    i="path to ttf or pixmap font" },
        font_size  = { x=false, f=false, a=false, v=12,                                         i="font size, does nothing for pixmap fonts" },
    },

    file = {
        prefs      = { x=false, f=true,  a=false, v="game.cfg",                                 i="filename for user preferences" },
        keys       = { x=false, f=true,  a=false, v="keys.cfg",                                 i="filename for shortkey definitions" },
    },

    misc = {
        valuepad   = { x=false, f=true,  a=false, v=20,                                         i="default padding for value column in user prefs file" },
    },
}
