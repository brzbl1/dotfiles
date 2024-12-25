-- au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
-- au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

local cmd = vim.cmd
local le, sp = '<leader>', '<space>'

---{key , func or cmd , {opts}}
---@param ... table
local function setKeys(...)
  for _, v in pairs { ... } do
    v[3] = v[3] or {}
    vim.keymap.set(v[3].m or 'n', v[1], v[2], { desc = v[3].d, silent = true })
  end
end

---keymapping
setKeys(
  { le .. sp, cmd.noh },
  { '<Esc><Esc>', '<C-\\><C-n>', { m = 't' } },
  ---改行で空白行を削除させない
  { 'o', 'oX<C-h><Esc>' },
  { 'O', 'OX<C-h><Esc>' },
  ---cursor move
  { 'H', '0', { m = { 'v', 'n' } } },
  { 'L', '$', { m = { 'v', 'n' } } },
  ---split
  { le .. '-', cmd.sp, { d = 'Split Horizontal' } },
  { le .. '|', cmd.vs, { d = 'Split Virtical' } },
  ---window
  { '<tab>', '<C-w>w' },
  ---telescope
  { sp .. ':cm', '<cmd>Telescope commands<CR>' },
  { sp .. ':ch', '<cmd>Telescope command_history<CR>' },
  { sp .. ':d', '<cmd>Telescope diagnostics<CR>' },
  { sp .. ':g', '<cmd>Telescope live_grep<CR>' },
  { sp .. ':h', '<cmd>Telescope help_tags<CR>' },
  { sp .. ':m', '<cmd>Telescope marks<CR>' },
  { sp .. ':r', '<cmd>Telescope registers<CR>' },
  { sp .. '::', '<cmd>Telescope<CR>' },
  ---
  { '<f5>', '<cmd>lua dofile(".config/nvim/lua/scryatch.lua")<cr>' }
)

---LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = InitG,
  callback = function()
    if package.loaded['lspsaga'] then
      setKeys(
        { sp .. 'lj', '<cmd>Lspsaga lsp_finder<cr>', { d = 'Jump to type_definition' } },
        { '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { d = 'Diagnostic goto_prev' } },
        { ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', { d = 'Diagnostic goto_next' } },
        { sp .. 'le', '<cmd>Lspsaga show_buf_diagnostics<cr>', { d = 'LSP Diagnostic' } },
        { le .. 's', '<cmd>Lspsaga outline<cr>', { d = ' Symbols OutLine' } }
      )
    else
      setKeys(
        { sp .. 'lj', vim.lsp.buf.type_definition, { d = 'Jump to type_definition' } },
        { '[d', vim.diagnostic.goto_prev, { d = 'Diagnostic goto_prev' } },
        { ']d', vim.diagnostic.goto_next, { d = 'Diagnostic goto_next' } },
        { le .. 'ls', vim.lsp.buf.document_symbol, { d = 'LSP Symbols' } }
      )
      -- { le .. 'lr', vim.lsp.buf.references, { d = 'LSP References' } }
      -- Bmap(l..'ls', vim.lsp.buf.document_symbol, { d = 'LSP Symbols' })
    end

    setKeys(
      { le .. 'ld', vim.lsp.buf.declaration, { d = 'LSP Declaration' } },
      { le .. 'li', vim.lsp.buf.implementation, { d = 'LSP Implementation' } },
      { le .. 'h', vim.lsp.buf.signature_help, { d = 'signature_help' } },
      { le .. 'r', vim.lsp.buf.rename, { d = 'LSP Rename' } },
      { le .. 'la', vim.lsp.buf.code_action, { d = 'LSP Code Action' } },
      { le .. 'f', vim.lsp.buf.format, { d = 'LSP Format' } },
      { le .. 'wa', vim.lsp.buf.add_workspace_folder },
      { le .. 'wr', vim.lsp.buf.remove_workspace_folder },
      { le .. 'wl', ':=vim.lsp.buf.list_workspace_folders()<cr>', { d = 'show Workspace' } }
    )
    -- {'<Char-100>','h')

    ---buffer
    if package.loaded.bufferline then
      setKeys(
        { ',.', '<cmd>BufferLinePick<cr>' },
        { ',,', '<cmd>BufferLinePickClose<cr>' }
      )
    else
      setKeys({ '<C-k>', cmd.bn }, { '<C-j>', cmd.bp })
    end

    ---pasta
    -- Bmap('p', require('pasta.mappings').p)
    -- Bmap('P', require('pasta.mappings').P)
  end,
})
