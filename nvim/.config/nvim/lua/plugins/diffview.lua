return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History (Branch)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History (Current File)" },
      { "<leader>gp", "<cmd>DiffviewOpen dev...HEAD<cr>", desc = "Diffview vs dev (merge-base)" },
      { "<leader>gP", "<cmd>DiffviewFileHistory --range=dev...HEAD<cr>", desc = "Diffview history vs dev (merge-base)" },
    },
  },
}
