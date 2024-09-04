local M = {}
local ut = require "rss.treedoc.utils"

M.rules = {}

M.rules.html = require "rss.treedoc.html"
M.rules.xml = require "rss.treedoc.xml"

---tree-sitter powered parser to turn html to simple lua table
---@param src string
---@param opts { rules: table, language: string }
---@return table
function M.parse(src, opts)
   opts = opts or {}
   local rules = opts.rules or M.rules[opts.language]
   local root = ut.get_root(src, opts.language)
   local iterator = vim.iter(root:iter_children())
   local collected = iterator:fold({}, function(acc, node)
      local T = node:type()
      acc[#acc + 1] = rules[T](node, src, rules)
      return acc
   end)
   return collected
end

return M
