require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end


require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

vim.cmd('runtime! plugin/rplugin.vim')
vim.api.nvim_set_hl(0, "MoltenOutputBorder", { ... })
-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- Toggle transparency
vim.api.nvim_set_var('terminal_emulator', 'powershell')

--vim.api.nvim_set_keymap('i', '<leader>m', '<Esc>:lua toggle_transparency()<CR>', { noremap = true, silent = true })

