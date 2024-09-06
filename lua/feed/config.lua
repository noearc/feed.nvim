--- Default configuration.
--- Provides fallback values not specified in the user config.

---@class feed.config
---@field keymaps feed.keymap[]
local default = {
   db_dir = "~/.local/share/nvim/feed",
   ---@alias feed.keymap table<string, string | function>
   keymaps = {
      ---@type feed.keymap
      index = {
         show_entry = "<CR>",
         show_in_split = "<M-CR>",
         show_in_browser = "b",
         show_in_w3m = "w",
         link_to_clipboard = "y",
         quit_index = "q",
         tag = "+",
         untag = "-",
         which_key = "?",
      },
      ---@type feed.keymap
      entry = {
         show_index = "q",
         show_next = "}",
         show_prev = "{",
         which_key = "?",
      },
   },
   win_options = {
      conceallevel = 0,
      wrap = true,
   },
   buf_options = {
      filetype = "markdown", -- TODO: rss?
      modifiable = false,
   },
   search = {
      sort_order = "descending",
      update_hook = {},
      filter = "@6-months-ago +unread",
   },
   layout = {
      title = {
         right_justify = false,
         width = 70,
      },
      date = {
         format = "%Y-%m-%d",
         width = 10,
      },
   },
   split = "13split",
   colorscheme = "kanagawa-lotus",

   ---@type feed.feed[]
   feeds = {},
}

local M = {}

setmetatable(M, {
   __index = function(self, key)
      local config = rawget(self, "config")
      if config then
         return config[key]
      end
      return default[key]
   end,
})

--- Merge the user configuration with the default values.
---@param config table<string, any> user configuration
function M.resolve(config)
   config = config or {}
   M.config = vim.tbl_deep_extend("keep", config, default)
end

return M
