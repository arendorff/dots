-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")
-- beautiful.init("/usr/share/awesome/themes/zenburn-red/theme.lua")
-- beautiful.init("/usr/share/awesome/themes/wombat/theme.lua")
beautiful.init("/home/mo/.config/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
browser = "firefox"
terminal = "alacritty"
terminal2 = "kitty --single-instance"
editor = "nvim"
-- editor = os.getenv("nvim") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mysystemmenu = {
   { "quit", terminal .. " -e shutdown now" },
   { "reboot", terminal .. " -e reboot" }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu },
                                    { "Terminal", terminal },
                                    { "Browser", browser },
                                    { "System", mysystemmenu}
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
    -- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, visible = false  })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            -- s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}



-- this is all for moving to previous/next tag
local gmath = require("gears.math")
local function move_to_previous_tag()
    local c = client.focus
    if not c then return end
    local t = c.screen.selected_tag
    local tags = c.screen.tags
    local idx = t.index
    local newtag = tags[gmath.cycle(#tags, idx - 1)]
    c:move_to_tag(newtag)
    awful.tag.viewprev()
end

local function move_to_next_tag()
    local c = client.focus
    if not c then return end
    local t = c.screen.selected_tag
    local tags = c.screen.tags
    local idx = t.index
    local newtag = tags[gmath.cycle(#tags, idx + 1)]
    c:move_to_tag(newtag)
    awful.tag.viewnext()
end

-- {{{ Key bindings
globalkeys = gears.table.join(

-- move to next/previous tag
    awful.key({ modkey, "Shift" }, "h", function (c) move_to_previous_tag() end,
             {description = "move client to previous tag", group = "tag"}),

    awful.key({ modkey, "Shift" }, "l", function (c) move_to_next_tag() end,
             {description = "move cliet to next tag", group = "tag"}),

-- toggle bar visibility


awful.key({ modkey,          }, "b",
            function()
              myscreen = awful.screen.focused()
              myscreen.mywibox.visible = not myscreen.mywibox.visible
            end,
              {description="toggle bar", group="awesome"}),

awful.key({ modkey,          }, "space",  function() client.focus = awful.client.getmaster(); client.focus:raise() end,
              {description="focus master", group="awesome"}),

    -- awful.key({ modkey,           }, "space",      awful.client.getmaster,
    --           {description="get master", group="awesome"}),

    -- awful.key({ modkey,         }, "space", function (c) c:swap(awful.client.getmaster()) end,
    --           {description = "move to master", group = "client"}),

    awful.key({ modkey, "Control" }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "l",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    -- awful.key({ modkey,           }, "a",  awful.tag.viewnext,
    --           {description = "view next alt", group = "tag"}),
    awful.key({ modkey,           }, "Tab", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),

    awful.key({ modkey,           }, "a",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index 2", group = "client"}
    ),

    -- awful.key({ modkey, "Shift"   }, "u",
    --     function ()
    --         awful.client.focus.byidx( 1)
    --     end,
    --     {description = "focus next by index", group = "client"}
    -- ),

    -- awful.key({ modkey,           }, "space",
    --     function ()
    --         awful.client.focus.byidx( 0)
    --     end,
    --     {description = "focus master", group = "client"}
    -- ),

    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              -- {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    -- awful.key({ modkey,           }, "t", function () awful.screen.focus_relative( 1) end,
              -- {description = "focus the next screen", group = "screen"}),
    -- awful.key({ modkey,           }, "s", function () awful.screen.focus_relative(-1) end,
              -- {description = "focus the previous screen", group = "screen"}),
    -- awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
    --           {description = "jump to urgent client", group = "client"}),
    -- awful.key({ modkey,           }, "Tab",
    --     function ()
    --         awful.client.focus.history.previous()
    --         if client.focus then
    --             client.focus:raise()
    --         end
    --     end,
    --     {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal2) end,
              {description = "open different terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    -- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    --           {description = "increase master width factor", group = "layout"}),
    -- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    --           {description = "decrease master width factor", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --           {description = "increase the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --           {description = "decrease the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "f", function () awful.layout.inc(-1)                end,
              {description = "select next", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "e", function () awful.layout.inc(-1)                end,
    --           {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control"   }, "g", function ()
        for s in screen do
    for _, t in ipairs(s.tags) do
        -- t.layout = awful.layout.suit.tile
        -- t.layout = awful.layout.inc(-1)
        t.gap = 10
    end
end
        end,
              {description = "toggle gaps", group = "layout"}),

    awful.key({ modkey, "Control"   }, "t", function ()
        for s in screen do
    for _, t in ipairs(s.tags) do
        t.layout = awful.layout.suit.tile
        -- t.layout = awful.layout.inc(-)
        -- t.gap = 0
    end
end
        end,
              {description = "change to tiling layout", group = "layout"}),

    awful.key({ modkey, "Control"   }, "f", function ()
        for s in screen do
    for _, t in ipairs(s.tags) do
        t.layout = awful.layout.suit.floating
        -- t.layout = awful.layout.inc(-1)
        -- t.gap = 0
    end
end
        end,
              {description = "change to floating layout", group = "layout"}),

    awful.key({ modkey, "Control" }, "j",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "d",     function ()
        awful.util.spawn("dmenu_run")
    end,
              {description = "launch dmenu", group = "launcher"}),

              -- launch programs
    awful.key({ modkey },            "w",     function ()
        awful.spawn("firefox")
    end,
              {description = "launch firefox", group = "programs"}),

    awful.key({ modkey, "Shift" },            "e",     function ()
        awful.spawn("thunderbird")
    end,
              {description = "launch thunderbird", group = "programs"}),

    awful.key({ modkey },            "e",     function ()
        awful.spawn("astroid")
    end,
              {description = "launch astroid", group = "programs"}),

    awful.key({ modkey },            "r",     function ()

        awful.spawn("pcmanfm")
    end,
              {description = "launch pcmanfm", group = "programs"}),

    awful.key({ modkey },            "t",     function ()
        awful.spawn("telegram-desktop")
    end,
              {description = "launch telegram", group = "programs"}),

    awful.key({ modkey, "Shift" },            "t",     function ()
        awful.spawn("signal-desktop")
    end,
              {description = "launch signal", group = "programs"}),

    awful.key({ modkey },            "o",     function ()
        -- awful.util.spawn("home/mo/scripts/dmenuscript.fish")
        awful.spawn.with_shell("/home/mo/sync/dots/x250/Scripts/dmenuscript.fish")
    end,
              {description = "dmenu script for opening files", group = "programs"}),

    awful.key({ modkey },            "y",     function ()
        -- awful.util.spawn("home/mo/scripts/dmenuscript.fish")
        awful.spawn.with_shell("/home/mo/scripts/youtube.sh")
    end,
              {description = "dmenu script for opening files", group = "programs"}),

    awful.key({ modkey },            "x",     function ()
        awful.spawn.with_shell("/home/mo/sync/dots/x250/Scripts/timebattery.fish")
    end,
              {description = "notification script", group = "programs"}),



    awful.key({ modkey, "Shift" },            "x",     function ()
        awful.spawn.with_shell("/home/mo/sync/dots/x250/Scripts/systemmenu.fish")
    end,
              {description = "system menu script", group = "programs"}),

    awful.key({ modkey },            "c",     function ()
        awful.spawn.with_shell("slock")
    end,
              {description = "system menu script", group = "programs"}),

    awful.key({ modkey },            "i",     function ()
        awful.spawn.with_shell("/home/mo/sync/dots/x250/Scripts/timebattery.fish")
    end,
              {description = "notification script", group = "programs"}),
    -- awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run {
    --                 prompt       = "Run Lua code: ",
    --                 textbox      = awful.screen.focused().mypromptbox.widget,
    --                 exe_callback = awful.util.eval,
    --                 history_path = awful.util.get_cache_dir() .. "/history_eval"
    --               }
    --           end,
    --           {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    -- awful.key({ modkey }, "p", function() menubar.show() end,
              -- {description = "show the menubar", group = "launcher"})

    awful.key({ }, "XF86Tools", function () os.execute("playerctl previous") end,
              {description = "previous", group = "hotkeys"}),

    awful.key({ }, "XF86Search", function () os.execute("playerctl play-pause") end,
              {description = "play/pause", group = "hotkeys"}),

    awful.key({ }, "XF86LaunchA", function () os.execute("playerctl next") end,
              {description = "next", group = "hotkeys"}),

    awful.key({ }, "XF86AudioLowerVolume", function () os.execute("amixer set Master 5%-") end,
              {description = "raise volume", group = "hotkeys"}),
    awful.key({ }, "XF86AudioRaiseVolume", function () os.execute("amixer set Master 5%+") end,
              {description = "lower volume", group = "hotkeys"}),
    awful.key({ }, "XF86AudioMute", function () os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle") end,
              {description = "mute volume", group = "hotkeys"}),


    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("brightnessctl set +5%") end,
              {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("brightnessctl set 5%-") end,
              {description = "-10%", group = "hotkeys"}),

    awful.key({ }, "XF86Display", function () os.execute("brightnessctl set 1%") end,
              {description = "+10%", group = "hotkeys"})

    -- awful.key("XF86AudioRaiseVolume",     function ()
    --     awful.util.spawn("amixer set Master 5%+")
    -- end,
    --           {description = "Raise volume", group = "Laptop controls"}),

    -- awful.key("XF86AudioLowerVolume",     function ()
    --     awful.util.spawn("amixer set Master 5%-")
    -- end,
    --           {description = "Lower volume", group = "Laptop controls"})



-- program[sound_increase] = amixer set Master 5%+
-- bind[sound_increase] = XF86AudioRaiseVolume

-- program[sound_decrease] = amixer set Master 5%-
-- bind[sound_decrease] = XF86AudioLowerVolume

-- program[sound_mute] = pactl set-sink-mute @DEFAULT_SINK@ toggle
-- bind[sound_mute] = XF86AudioMute

-- # brightness

-- program[brightness_increase] = brightnessctl set +5%
-- bind[brightness_increase] = XF86MonBrightnessUp

-- program[brightness_decrease] = brightnessctl set 5%-
-- bind[brightness_decrease] = XF86MonBrightnessDown

-- program[brightness_min] = brightnessctl set 1%
-- bind[brightness_min] = XF86Display


)

clientkeys = gears.table.join(

   -- toggle titlebar in current window
   -- awful.key({ modkey, "Control" }, "f", function (c)
        -- for _, c in ipairs(client.get()) do
            -- awful.titlebar.toggle(c)
            -- this doesn't work
            -- awful.layout.inc(-1)
        -- end
            -- myscreen = awful.screen.focused()
            -- myscreen.mywibox.visible = not myscreen.mywibox.visible
            -- awful.layout.set(awful.layout.suit.tile)
            -- local currentlayout = awful.layout.get(s)
            -- if currentlayout == awful.layout.suit.floating then
                -- awful.layout.set(awful.layout.suit.tile)
                -- else
                -- awful.layout.set(awful.layout.suit.floating)
            -- end
    -- end,
             -- {description = "Show/Hide Titlebars", group="client"}),


    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    -- awful.key({ modkey,           }, "o",
    --     function switch(direction)
    --         local s = awful.screen.focused()
    --         local tags = s.tags
    --         local next_index = s.selected_tag.index + direction

            -- for i = next_index, direction > 0 and #tags or 1, direction do
            --     local t = tags[i]
            --     if #t:clients() > 0 then
            --         t:view_only()
            --         return
            --     end
            -- end
        -- end,
        -- {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),

    awful.key({ modkey, "Shift" }, "a",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),

    awful.key({ modkey, "Shift" }, "space", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"})





    -- awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end
              -- {description = "move to screen", group = "client"}),
    -- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              -- {description = "toggle keep on top", group = "client"}),
    -- awful.key({ modkey,           }, "n",
        -- function (c)
            -- -- The client currently has the input focus, so it cannot be
            -- -- minimized, since minimized clients can't have the focus.
            -- c.minimized = true
        -- end ,
        -- {description = "minimize", group = "client"}),
    -- awful.key({ modkey,           }, "m",
        -- function (c)
            -- c.maximized = not c.maximized
            -- c:raise()
        -- end ,
        -- {description = "(un)maximize", group = "client"}),
    -- awful.key({ modkey, "Control" }, "m",
        -- function (c)
            -- c.maximized_vertical = not c.maximized_vertical
            -- c:raise()
        -- end ,
        -- {description = "(un)maximize vertically", group = "client"}),
    -- awful.key({ modkey, "Shift"   }, "m",
        -- function (c)
            -- c.maximized_horizontal = not c.maximized_horizontal
            -- c:raise()
        -- end ,
        -- {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                           -- how to call a local variable in lua?
                           -- or just call the notification thing in awesome directly.
                           -- awful.spawn.with_shell('notify-send "Switching to tag #"')
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

       { rule_any = {type = { "normal", "dialog" }
     }, properties = { titlebars_enabled = true }
   },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Steam",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    { rule = { class = "KeePassXC" },
      properties = { tag = "5" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            -- awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            -- awful.titlebar.widget.stickybutton   (c),
            -- awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }

    -- hide titlebar by default
    awful.titlebar.hide(c)

end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}



-- autostart

awful.spawn.with_shell("/home/mo/sync/dots/x250/.config/spectrwm/autostart.sh")
-- awful.spawn.with_shell("")





-- --  next occupied tag. gives me errors though
-- function switch(direction)
--     local s = awful.screen.focused()
--     local tags = s.tags
--     local next_index = s.selected_tag.index + direction

    -- for i = next_index, direction > 0 and #tags or 1, direction do
    --     local t = tags[i]
    --     if #t:clients() > 0 then
    --         t:view_only()
    --         return
    --     end
    -- end
-- end
