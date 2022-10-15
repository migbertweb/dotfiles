local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node

ls.parser.parse_snippet("lm", "local M = {}\n\nfunction M.setup()\n  $1 \nend\n\nreturn M")

