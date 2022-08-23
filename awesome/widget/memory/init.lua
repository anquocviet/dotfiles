-- ## Memory ##
-- ~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local wibox = require('wibox')
local beautiful = require('beautiful')
local watch = require('awful.widget.watch')
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}
theme.iconfont = "Font Awesome 6 Free Solid 12"
local memory = wibox.widget.textbox()
memory.font = theme.font

function round(exact, quantum)
    local quant,frac = math.modf(exact/quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end

watch('bash -c "free | grep -z Mem.*Swap.*"', 2, function(_, stdout)
    local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
        stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

    memory.text = round((used / 1048576), 0.01) .. ' GB'
    collectgarbage('collect')
end)

--return memory
memory_icon = wibox.widget {
	markup = '<span font="' .. theme.iconfont .. '"> </span>',
	widget = wibox.widget.textbox,
}
return wibox.widget {

	wibox.widget{
		memory_icon,
		fg = colors.black,
		widget = wibox.container.background
	},
    	wibox.widget{
        	memory, 
        	fg = colors.black,
        	widget = wibox.container.background
    	},
    	spacing = dpi(2),
    	layout = wibox.layout.fixed.horizontal
}
