-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Sidebar toggle
vim.keymap.set("n", "<C-n>", "<leader>e", { remap = true, desc = "Toggle Explorer" })

-- Tab / Shift+Tab to cycle buffers
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })

-- Leader+fw to search words (grep)
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find Words" })

-- Leader+/ to toggle comments
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle Comment" })
