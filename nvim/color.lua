-- vim.cmd.colorscheme('torte')
-- CursorLineSign xxx links to SignColumn

local hilights = {
  Normal = { bg = '#292d3e' },
  -- Normal = { bg = '#223344' },
  -- Normal = { fg = '#cccccc', bg = '#223344' },
  CursorLine = { bg = '#112233' },
  Folded = { fg = '#ff9933', bg = '#335533' },
  linenr = { fg = '#dd8833' },
  search = { fg = '#111111', bg = '#dddd11' },
  NonText = { fg = 'LightGreen' },
  comment = { fg = '#aaee44' },
  SignColumn = { link = 'Normal' },
  Conceal = { bg = '#333388' },
  -- link = "Normal"
  identifier = { fg = '#77ffff' },
  string = { fg = '#ffccff' },
  Visual = { bg = '#555555' }, ---selected item in popup
  -- Whitespace = { fg = '#cccccc'},

  ---StatusLine-
  statusline = { fg = '#eeddcc', bg = '#292d3e', bold = true },
  statuslineNC = { fg = '#aaaaaa', bg = '#3344cc' },
  ---cmp_nvim---
  CmpItemAbbrMatchDefault = { link = 'Identifier' },
  markdownError = { link = 'Normal' },
  Error = { link = 'Normal' },

  ---popup color
  PmenuSel = { fg = '#222222', bg = '#dddd00' },
  Pmenu = { bg = '#303030' },

  TODO = { fg = '#000000', bg = '#3344ff' },
}

vim.cmd [[colorscheme vim]]

for ns, v in pairs(hilights) do
  vim.api.nvim_set_hl(0, ns, v)
end
