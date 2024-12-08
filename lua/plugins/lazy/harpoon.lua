local local_plugins = {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()
            vim.keymap.set('', '<C-e>', '<Nop>', { noremap = true, silent = true })
            vim.keymap.set('', '<leader>a', '<Nop>', { noremap = true, silent = true })

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-M-h>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-M-j>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-M-k>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-M-l>", function() harpoon:list():select(4) end)
            vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
            vim.keymap.set("n", "<leader><C-j>", function() harpoon:list():replace_at(2) end)
            vim.keymap.set("n", "<leader><C-k>", function() harpoon:list():replace_at(3) end)
            vim.keymap.set("n", "<leader><C-l>", function() harpoon:list():replace_at(4) end)
        end
    },
}

return local_plugins
