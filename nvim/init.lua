if vim.loader then
	vim.loader.enable()
end
local o = vim.opt

-- local signs = { Error = "󰂭", Warn = "󰹇", Info = "󰩕", Hint = "" }
local signs = { Error = "󱠱", Warn = "󰹇", Info = "󰩕", Hint = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

Symbols = {
	Text = "󰦨",
	Method = "ƒ",
	Function = "",
	Constructor = "",
	Field = "🏷️",
	Variable = "",
	Class = "𝓒",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "∡",
	Value = "",
	Enum = "",
	Keyword = "🔑",
	Snippet = "",
	Color = "",
	Reference = "",
	EnumMember = "",
	TypeParameter = "𝙏",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "+",
	File = "📄",
	Folder = "📂",
}

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.lsp.set_log_level(4)

o.ambiwidth = "single"
o.encoding = "utf-8"

o.number = true
o.termguicolors = true
o.cursorline = true
-- o.cursorcolumn = true
o.list = true --タブ、スペース、改行文字を可視化
-- cmd('syntax on')

o.virtualedit = "onemore,block"
-- o.wildmode = {'list','longest'}
o.showcmd = true
o.splitbelow = true
o.splitright = true
o.listchars = { tab = "▸ ", trail = "_", eol = "↲", extends = "»", precedes = "«", nbsp = "%" }

---move-------------
o.mouse = "a" -- Enable mouse wheeling
o.whichwrap = "<,>,[,]" -- 行をまたいで移動
-- local h = vim.api.nvim_win_get_height(0)
-- vim.o.scrolloff = math.floor(h / 2)
o.scrolloff = 13
o.sidescrolloff = 8
o.startofline = false
o.sms = true

---indent/tab---
o.expandtab = true
o.ts = 2
o.sw = 0 -- 0にすることでtabstopに従う
o.sts = -1 --負数にすると shiftwidth (sw) に従う
o.cindent = true
o.shiftround = true

---other
o.grepprg = "rg --vimgrep"
o.history = 200
o.conceallevel = 2
o.wildignorecase = true
o.relativenumber = true
o.pyxversion = 3
o.clipboard = "unnamedplus"
o.ignorecase = true
o.smartcase = true
--o.noswapfile = true
o.pumheight = 16
o.showcmd = true
o.confirm = true
-- o.pumblend = 10
-- o.completeopt = 'menu,menuone,noinsert'
o.completeopt = "menu,noselect,noinsert,preview"
o.sessionoptions = "buffers,curdir,folds"
-- cmd('set runtimepath=$VIMRUNTIME')
vim.cmd.filetype("on")
-- cmd('filetype plugin on')

-- o.backup = true

--- autocommands ===
InitG = vim.api.nvim_create_augroup("InitGroup", {})

local function autocmd(events, func, pattern)
	vim.api.nvim_create_autocmd(events, {
		group = InitG,
		pattern = pattern,
		callback = vim.is_callable(func) and func or nil,
		command = type(func) == "string" and func or nil,
	})
end

autocmd("FileType", function()
	vim.keymap.set("n", "q", ":bd<cr>", { buffer = 0 })
end, { "help", "man", "notify", "qf", "query" })
-- autocmd("FileType", "wincmd L", { "help", "man" })

autocmd("FileType", function()
	vim.bo.cms = "# %s"
end, { "nim" })

-- autocmd("FileType", function()
--   local w_c = vim.api.nvim_get_current_win()
--   vim.wo[w_c].foldmethod = "indent"
--   vim.wo[w_c].foldlevel = 1
-- end, { "lua" })

autocmd("TermClose", function(ev)
	if not ev.file:match(vim.pesc("fm-nvim")) then
		vim.api.nvim_input("\\<cr>")
	end
end)

autocmd("TermOpen", "startinsert|setlocal nonumber norelativenumber")
autocmd("BufWritePost", "so $MYVIMRC", vim.fn.expand("$MYVIMRC"))
autocmd("BufWritePre", [[%s/\s\+$//e]])
autocmd({ "InsertLeave", "CmdwinLeave" }, [[call system('fcitx5-remote -c')]])
-- autocmd("VimLeavePre", "delmark! | wviminfo!", "*")

-----------
vim.cmd([[let g:mapleader = "\<Space>"]])

require("lazy_rc")
require("keys")
require("color")
require("analyzer")

-- vim.fn.sign_define('Identifier', { text = 'F', texthl = 'Identifier', numhl = "" })
-- o.laststatus = 3
-- vim.cmd('au FileType help setlocal laststatus=0')

---UserCommand

vim.api.nvim_create_user_command("Config", function()
	vim.cmd("Telescope find_files find_command=fd,-t,f,\\.lua,./.config/nvim")
end, {})

vim.api.nvim_create_user_command("ClearMarks", function()
	vim.cmd("delmark! | wviminfo!")
end, {})

vim.api.nvim_create_user_command("P", [[luafile ~/.config/nvim/lua/pg.lua]], {})
