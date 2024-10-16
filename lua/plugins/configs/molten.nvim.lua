-- Enable for .qmd files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qmd",
  callback = function()
    vim.g.molten_virt_text_output = true
  end,
})

-- Disable for .py files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.g.molten_virt_text_output = false
  end,
})
