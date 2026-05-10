-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Prefer .git as the root marker over package.json
vim.g.root_spec = { { ".git" }, "cwd" }

-- Set to "basedpyright" to use basedpyright instead of "pyright".
vim.g.lazyvim_python_lsp = "basedpyright"

-- Disable auto formatting
vim.g.autoformat = false
