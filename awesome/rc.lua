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
require("awful.hotkeys_popup.keys")


local theme_path = string.format("%s/.config/awesome/themes/theme.lua", os.getenv("HOME"))
beautiful.init(theme_path)
beautiful.useless_gap = 4


require("configuration.layouts")
require("configuration.keys")

-- Menubar
require("ui.menu")

-- Wibar on top screen
require("ui.bar")

-- Rules
require("configuration.rules")

-- Signals
require("configuration.signals")

-- Auto startup
awful.spawn.with_shell("~/.config/awesome/autorun.sh")



