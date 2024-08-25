local render = require("render")
local fetch = require("fetch")
local M = {}

local srcs = {
	["少数派"] = "https://sspai.com/feed",
	arch = "https://archlinux.org/feeds/news/",
	["机核"] = "https://www.gcores.com/rss",
	zig = "https://andrewkelley.me/rss.xml",
	bbc = "https://feeds.bbci.co.uk/news/world/rss.xml",
}
local actions = {}

function actions.update()
	for name, link in pairs(srcs) do
		fetch.update_feed(link, name)
	end
end

-- TODO: autocomp when using usrcmd
function actions.update_feed(name)
	fetch.update_feed(srcs[name], name)
end

vim.api.nvim_create_user_command("Rss", function(opts)
	if #opts.fargs > 1 then -- TODO:
		error("too much args!")
	else
		actions[opts.args]()
	end
end, { nargs = 1 })

function M.setup(config)
	vim.keymap.set("n", "<leader>rs", render.render_telescope, { desc = "Show [R][s]s feed" })
	vim.keymap.set("n", "<leader>rr", render.render_flat, { desc = "Show [R][s]s feed" })
end

return M
