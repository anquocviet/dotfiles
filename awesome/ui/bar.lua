local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local battery = require("widget.battery")
local cpu = require("widget.cpu")
local memory = require("widget.memory")
local clock = require("widget.clock")

-- Tags 
local names =  { " ", " ", " ", " ", " ", " ", " ", " ", " " }

local l = awful.layout.suit  -- Just to save some typing: use an alias.
local layouts = { l.tile, l.tile, l.tile, l.floating }
awful.tag(names, s, layouts)

-- {{{ Wibar

-- Create a wibar for each screen and add it
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


        -- Create a promptbox for each screen
     s.mypromptbox = awful.widget.prompt()
     -- Create an imagebox widget which will contain an icon indicating which layout we're u    sing.
     -- We need one layoutbox per screen.
     s.mylayoutbox = awful.widget.layoutbox(s)
     s.mylayoutbox:buttons(gears.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    --
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        --filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }


-- Barcontainer :
local function barcontainer(widget, color_widget)
    local container = wibox.widget
      {
        widget,
        top = dpi(4),
        bottom = dpi(4),
        left = dpi(4),
        right = dpi(4),
        widget = wibox.container.margin
    }
    local box = wibox.widget{
        {
            container,
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(8),
            right = dpi(8),
            widget = wibox.container.margin
        },
        bg = color_widget,
        shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,8) end,
        widget = wibox.container.background
    }
return wibox.widget{
        box,
        top = dpi(4),
        bottom = dpi(4),
        right = dpi(2),
        left = dpi(2),
        widget = wibox.container.margin
    }
end


-- Create the wibox
    s.mywibar = awful.wibar({ 
	position = "top",
	type = "dock",
	ontop = false,
	stretch = false,
	visible = true,
	height = dpi(36),
	width = s.geometry.width,
	screen = s,
	bg = colors.transparent,        -- Color of the wibox on top
    })

--awful.placement.top(s.mywibar, { margins = beautiful.useless_gap })
s.mywibar:struts({ 
	top = dpi(33),
	bottom = dpi(0),
})

s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            barcontainer(s.mytaglist, '#2D3030'),
            -- s.mypromptbox,
            barcontainer(wibox.widget.systray(), colors.black),
            
        },

        {
            layout = wibox.layout.fixed.vertical,
        },

        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --mykeyboardlayout,
            barcontainer(memory, colors.brightyellow),
            barcontainer(cpu, colors.brightmagenta),
            barcontainer(battery, colors.brightgreen),
            barcontainer(clock, colors.brightblue),
            barcontainer(s.mylayoutbox, colors.brightblack),
            spacing = dpi(4)
        },
    }


end)
-- }}}


